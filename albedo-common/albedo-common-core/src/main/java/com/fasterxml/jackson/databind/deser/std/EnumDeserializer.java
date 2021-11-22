package com.fasterxml.jackson.databind.deser.std;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.converter.EnumSerializer;
import com.albedo.java.common.core.util.StrPool;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.JacksonStdImpl;
import com.fasterxml.jackson.databind.cfg.CoercionAction;
import com.fasterxml.jackson.databind.cfg.CoercionInputShape;
import com.fasterxml.jackson.databind.deser.ContextualDeserializer;
import com.fasterxml.jackson.databind.deser.SettableBeanProperty;
import com.fasterxml.jackson.databind.deser.ValueInstantiator;
import com.fasterxml.jackson.databind.introspect.AnnotatedMethod;
import com.fasterxml.jackson.databind.type.LogicalType;
import com.fasterxml.jackson.databind.util.ClassUtil;
import com.fasterxml.jackson.databind.util.CompactStringObjectMap;
import com.fasterxml.jackson.databind.util.EnumResolver;

import java.io.IOException;
import java.util.Objects;

/**
 * 枚举类反序列化程序类，可以从字符串和整数反序列化指定枚举类的实例。
 * 官方提供的，支持（但不限于）以下接收方式：
 * 1、字符串 如：sex: "M"
 * 2、数字   如：sex: 1    // 数字需要和枚举类的顺序对应，超过会报错。 如Sex 有M、W、N  ，则数字只能是 0、1、2
 * 3、数组   还不清楚怎么使用...
 * <p>
 * <p>
 * 我重写了后，增强了以下功能。
 * 1、传递的枚举类型可以是对象. 如： sex: { "code": "M" }
 * <p>
 * 本类跟jackson-databind包中的EnumDeserializer类同包名，利用类加载机制，会加载此类，不会加载到jackson-databind中的类
 * 参考 BasicDeserializerFactory#1495 行代码
 *
 * @author zuihou
 * @version 3.2.1
 */
@SuppressWarnings("ALL")
@JacksonStdImpl // was missing until 2.6
public class EnumDeserializer
        extends StdScalarDeserializer<Object>
        implements ContextualDeserializer {
    private static final long serialVersionUID = 1L;
    /**
     * @since 2.7.3
     */
    protected final CompactStringObjectMap _lookupByName;
    protected final Boolean _caseInsensitive;
    /**
     * @since 2.8
     */
    private final Enum<?> _enumDefaultValue;
    protected Object[] _enumsByIndex;
    /**
     * Alternatively, we may need a different lookup object if "use toString"
     * is defined.
     *
     * @since 2.7.3
     */
    protected CompactStringObjectMap _lookupByToString;

    /**
     * @since 2.9
     */
    public EnumDeserializer(EnumResolver byNameResolver, Boolean caseInsensitive) {
        super(byNameResolver.getEnumClass());
        _lookupByName = byNameResolver.constructLookup();
        _enumsByIndex = byNameResolver.getRawEnums();
        _enumDefaultValue = byNameResolver.getDefaultValue();
        _caseInsensitive = caseInsensitive;
    }

    /**
     * @since 2.9
     */
    protected EnumDeserializer(EnumDeserializer base, Boolean caseInsensitive) {
        super(base);
        _lookupByName = base._lookupByName;
        _enumsByIndex = base._enumsByIndex;
        _enumDefaultValue = base._enumDefaultValue;
        _caseInsensitive = caseInsensitive;
    }

    /**
     * @deprecated Since 2.9
     */
    @Deprecated
    public EnumDeserializer(EnumResolver byNameResolver) {
        this(byNameResolver, null);
    }

    /**
     * @deprecated Since 2.8
     */
    @Deprecated
    public static JsonDeserializer<?> deserializerForCreator(DeserializationConfig config,
                                                             Class<?> enumClass, AnnotatedMethod factory) {
        return deserializerForCreator(config, enumClass, factory, null, null);
    }

    /**
     * Factory method used when Enum instances are to be deserialized
     * using a creator (static factory method)
     *
     * @return Deserializer based on given factory method
     * @since 2.8
     */
    public static JsonDeserializer<?> deserializerForCreator(DeserializationConfig config,
                                                             Class<?> enumClass, AnnotatedMethod factory,
                                                             ValueInstantiator valueInstantiator, SettableBeanProperty[] creatorProps) {
        if (config.canOverrideAccessModifiers()) {
            ClassUtil.checkAndFixAccess(factory.getMember(),
                    config.isEnabled(MapperFeature.OVERRIDE_PUBLIC_ACCESS_MODIFIERS));
        }
        return new FactoryBasedEnumDeserializer(enumClass, factory,
                factory.getParameterType(0),
                valueInstantiator, creatorProps);
    }

    /**
     * Factory method used when Enum instances are to be deserialized
     * using a zero-/no-args factory method
     *
     * @return Deserializer based on given no-args factory method
     * @since 2.8
     */
    public static JsonDeserializer<?> deserializerForNoArgsCreator(DeserializationConfig config,
                                                                   Class<?> enumClass, AnnotatedMethod factory) {
        if (config.canOverrideAccessModifiers()) {
            ClassUtil.checkAndFixAccess(factory.getMember(),
                    config.isEnabled(MapperFeature.OVERRIDE_PUBLIC_ACCESS_MODIFIERS));
        }
        return new FactoryBasedEnumDeserializer(enumClass, factory);
    }

    /**
     * @since 2.9
     */
    public EnumDeserializer withResolved(Boolean caseInsensitive) {
        if (Objects.equals(_caseInsensitive, caseInsensitive)) {
            return this;
        }
        return new EnumDeserializer(this, caseInsensitive);
    }

    @Override // since 2.9
    public JsonDeserializer<?> createContextual(DeserializationContext ctxt,
                                                BeanProperty property) throws JsonMappingException {
        Boolean caseInsensitive = findFormatFeature(ctxt, property, handledType(),
                JsonFormat.Feature.ACCEPT_CASE_INSENSITIVE_PROPERTIES);
        if (caseInsensitive == null) {
            caseInsensitive = _caseInsensitive;
        }
        return withResolved(caseInsensitive);
    }

    /*
    /**********************************************************
    /* Default JsonDeserializer implementation
    /**********************************************************
     */

    /**
     * Because of costs associated with constructing Enum resolvers,
     * let's cache instances by default.
     */
    @Override
    public boolean isCachable() {
        return true;
    }

    @Override // since 2.12
    public LogicalType logicalType() {
        return LogicalType.Enum;
    }

    @Override // since 2.12
    public Object getEmptyValue(DeserializationContext ctxt) throws JsonMappingException {
        return _enumDefaultValue;
    }

    @Override
    public Object deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        JsonToken curr = p.currentToken();

        // Usually should just get string value:
        // 04-Sep-2020, tatu: for 2.11.3 / 2.12.0, removed "FIELD_NAME" as allowed;
        //   did not work and gave odd error message.
        if (curr == JsonToken.VALUE_STRING) {
            return _fromString(p, ctxt, p.getText());
        }

        // zuihou 新增的代码！ 支持前端传递对象 {"code": "xx"}
        if (curr == JsonToken.START_OBJECT) {
            CompactStringObjectMap lookup = ctxt.isEnabled(DeserializationFeature.READ_ENUMS_USING_TO_STRING)
                    ? _getToStringLookup(ctxt) : _lookupByName;
            JsonNode node = p.getCodec().readTree(p);
            JsonNode code = node.get(EnumSerializer.ALL_ENUM_KEY_FIELD);
            String name = code != null ? code.asText() : node.asText();
            if (StrUtil.isBlank(name) || StrPool.NULL.equals(name)) {
                return null;
            }
            Object result = lookup.find(name);
            if (result == null) {
                return _deserializeAltString(p, ctxt, lookup, name);
            }
            return result;
        }

        // But let's consider int acceptable as well (if within ordinal range)
        if (curr == JsonToken.VALUE_NUMBER_INT) {
            return _fromInteger(p, ctxt, p.getIntValue());
        }

        // 29-Jun-2020, tatu: New! "Scalar from Object" (mostly for XML)
        if (p.isExpectedStartObjectToken()) {
            return _fromString(p, ctxt,
                    ctxt.extractScalarFromObject(p, this, _valueClass));
        }
        return _deserializeOther(p, ctxt);
    }

    protected Object _fromString(JsonParser p, DeserializationContext ctxt,
                                 String text)
            throws IOException {
        CompactStringObjectMap lookup = ctxt.isEnabled(DeserializationFeature.READ_ENUMS_USING_TO_STRING)
                ? _getToStringLookup(ctxt) : _lookupByName;
        // zuihou 增强
        if (StrUtil.isBlank(text) || StrPool.NULL.equals(text)) {
            return null;
        }
        Object result = lookup.find(text);
        if (result == null) {
            String trimmed = text.trim();
            if ((trimmed == text) || (result = lookup.find(trimmed)) == null) {
                return _deserializeAltString(p, ctxt, lookup, trimmed);
            }
        }
        return result;
    }

    protected Object _fromInteger(JsonParser p, DeserializationContext ctxt,
                                  int index)
            throws IOException {
        final CoercionAction act = ctxt.findCoercionAction(logicalType(), handledType(),
                CoercionInputShape.Integer);

        // First, check legacy setting for slightly different message
        if (act == CoercionAction.Fail) {
            if (ctxt.isEnabled(DeserializationFeature.FAIL_ON_NUMBERS_FOR_ENUMS)) {
                return ctxt.handleWeirdNumberValue(_enumClass(), index,
                        "not allowed to deserialize Enum value out of number: disable DeserializationConfig.DeserializationFeature.FAIL_ON_NUMBERS_FOR_ENUMS to allow"
                );
            }
            // otherwise this will force failure with new setting
            _checkCoercionFail(ctxt, act, handledType(), index,
                    "Integer value (" + index + ")");
        }
        switch (act) {
            case AsNull:
                return null;
            case AsEmpty:
                return getEmptyValue(ctxt);
            case TryConvert:
            default:
        }
        if (index >= 0 && index < _enumsByIndex.length) {
            return _enumsByIndex[index];
        }
        if ((_enumDefaultValue != null)
                && ctxt.isEnabled(DeserializationFeature.READ_UNKNOWN_ENUM_VALUES_USING_DEFAULT_VALUE)) {
            return _enumDefaultValue;
        }
        if (!ctxt.isEnabled(DeserializationFeature.READ_UNKNOWN_ENUM_VALUES_AS_NULL)) {
            return ctxt.handleWeirdNumberValue(_enumClass(), index,
                    "index value outside legal index range [0..%s]",
                    _enumsByIndex.length - 1);
        }
        return null;
    }

    /*
    /**********************************************************
    /* Internal helper methods
    /**********************************************************
     */

    private final Object _deserializeAltString(JsonParser p, DeserializationContext ctxt,
                                               CompactStringObjectMap lookup, String nameOrig) throws IOException {
        String name = nameOrig.trim();
        if (name.isEmpty()) {
            // 07-Jun-2021, tatu: [databind#3171] Need to consider Default value first
            //   (alas there's bit of duplication here)
            if ((_enumDefaultValue != null)
                    && ctxt.isEnabled(DeserializationFeature.READ_UNKNOWN_ENUM_VALUES_USING_DEFAULT_VALUE)) {
                return _enumDefaultValue;
            }
            if (ctxt.isEnabled(DeserializationFeature.READ_UNKNOWN_ENUM_VALUES_AS_NULL)) {
                return null;
            }

            CoercionAction act;
            if (nameOrig.isEmpty()) {
                act = _findCoercionFromEmptyString(ctxt);
                act = _checkCoercionFail(ctxt, act, handledType(), nameOrig,
                        "empty String (\"\")");
            } else {
                act = _findCoercionFromBlankString(ctxt);
                act = _checkCoercionFail(ctxt, act, handledType(), nameOrig,
                        "blank String (all whitespace)");
            }
            switch (act) {
                case AsEmpty:
                case TryConvert:
                    return getEmptyValue(ctxt);
                case AsNull:
                default: // Fail already handled earlier
            }
            return null;
//            if (ctxt.isEnabled(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT)) {
        } else {
            // [databind#1313]: Case insensitive enum deserialization
            if (Boolean.TRUE.equals(_caseInsensitive)) {
                Object match = lookup.findCaseInsensitive(name);
                if (match != null) {
                    return match;
                }
            } else if (!ctxt.isEnabled(DeserializationFeature.FAIL_ON_NUMBERS_FOR_ENUMS)) {
                // [databind#149]: Allow use of 'String' indexes as well -- unless prohibited (as per above)
                char c = name.charAt(0);
                if (c >= '0' && c <= '9') {
                    try {
                        int index = Integer.parseInt(name);
                        if (!ctxt.isEnabled(MapperFeature.ALLOW_COERCION_OF_SCALARS)) {
                            return ctxt.handleWeirdStringValue(_enumClass(), name,
                                    "value looks like quoted Enum index, but `MapperFeature.ALLOW_COERCION_OF_SCALARS` prevents use"
                            );
                        }
                        if (index >= 0 && index < _enumsByIndex.length) {
                            return _enumsByIndex[index];
                        }
                    } catch (NumberFormatException e) {
                        // fine, ignore, was not an integer
                    }
                }
            }
        }
        if ((_enumDefaultValue != null)
                && ctxt.isEnabled(DeserializationFeature.READ_UNKNOWN_ENUM_VALUES_USING_DEFAULT_VALUE)) {
            return _enumDefaultValue;
        }
        if (ctxt.isEnabled(DeserializationFeature.READ_UNKNOWN_ENUM_VALUES_AS_NULL)) {
            return null;
        }
        return ctxt.handleWeirdStringValue(_enumClass(), name,
                "not one of the values accepted for Enum class: %s", lookup.keys());
    }

    protected Object _deserializeOther(JsonParser p, DeserializationContext ctxt) throws IOException {
        // [databind#381]
        if (p.hasToken(JsonToken.START_ARRAY)) {
            return _deserializeFromArray(p, ctxt);
        }
        return ctxt.handleUnexpectedToken(_enumClass(), p);
    }

    protected Class<?> _enumClass() {
        return handledType();
    }

    protected CompactStringObjectMap _getToStringLookup(DeserializationContext ctxt) {
        CompactStringObjectMap lookup = _lookupByToString;
        // note: exact locking not needed; all we care for here is to try to
        // reduce contention for the initial resolution
        if (lookup == null) {
            synchronized (this) {
                lookup = EnumResolver.constructUsingToString(ctxt.getConfig(), _enumClass())
                        .constructLookup();
            }
            _lookupByToString = lookup;
        }
        return lookup;
    }
}
