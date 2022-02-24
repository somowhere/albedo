/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.core.util;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ReflectUtil;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.BridgeMethodResolver;
import org.springframework.core.DefaultParameterNameDiscoverer;
import org.springframework.core.MethodParameter;
import org.springframework.core.ParameterNameDiscoverer;
import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.core.annotation.SynthesizingMethodParameter;
import org.springframework.web.method.HandlerMethod;

import java.io.File;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

/**
 * 类工具类
 *
 * @author somewhere
 */
@UtilityClass
@Slf4j
public class ClassUtil extends org.springframework.util.ClassUtils {

	private static final String SETTER_PREFIX = "set";

	private static final String GETTER_PREFIX = "get";

	private final ParameterNameDiscoverer PARAMETERNAMEDISCOVERER = new DefaultParameterNameDiscoverer();

	/**
	 * 循环向上转型, 获取对象的DeclaredField, 并强制设置为可访问. 如向上转型到Object仍无法找到, 返回null.
	 */
	public static Field getAccessibleField(final Object obj, final String fieldName) {
		return getAccessibleField(obj.getClass(), fieldName);
	}

	/**
	 * 改变private/protected的成员变量为public，尽量不调用实际改动的语句，避免JDK的SecurityManager抱怨。
	 */
	public static void makeAccessible(Field field) {
		boolean flag = (!Modifier.isPublic(field.getModifiers())
			|| !Modifier.isPublic(field.getDeclaringClass().getModifiers())
			|| Modifier.isFinal(field.getModifiers())) && !field.isAccessible();
		if (flag) {
			field.setAccessible(true);
		}
	}

	/**
	 * 循环向上转型, 获取对象的DeclaredField, 并强制设置为可访问. 如向上转型到Object仍无法找到, 返回null.
	 */
	public static Field getAccessibleField(final Class<?> cls, final String fieldName) {
		ArgumentAssert.notNull(cls, "cls can't be null");
		ArgumentAssert.notEmpty(fieldName, "fieldName can't be blank");
		for (Class<?> superClass = cls; superClass != Object.class; superClass = superClass.getSuperclass()) {
			try {
				Field field = superClass.getDeclaredField(fieldName);
				makeAccessible(field);
				return field;
			} catch (NoSuchFieldException e) {// NOSONAR
				// Field不在当前类定义,继续向上转型
				continue;// new add
			}
		}
		return null;
	}

	/**
	 * 创建对象，注入指定属性值
	 *
	 * @param cls
	 * @param fields
	 * @param value
	 * @param <T>
	 * @return
	 */
	public static <T> T createObj(Class<T> cls, List<String> fields, Object... value) {
		Object obj = null;
		try {
			obj = updateObj(cls.newInstance(), fields, value);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return (T) obj;
	}

	/**
	 * 更新对象，注入指定属性值
	 *
	 * @param obj
	 * @param fields
	 * @param value
	 * @return
	 */
	public static <T> T updateObj(Object obj, List<String> fields, Object... value) {
		try {
			if (obj != null) {
				if (ObjectUtil.isNotEmpty(fields) && ObjectUtil.isNotEmpty(value) && value.length == fields.size()) {
					for (int i = 0; i < fields.size(); i++) {
						BeanUtil.setFieldValue(obj, fields.get(i), value[i]);
					}
				} else {
					log.warn("obj {} fields {} value {}", obj, fields, value);
				}
			} else {
				log.warn("obj is null");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return (T) obj;
	}

	/**
	 * 调用Getter方法. 支持多级，如：对象名.对象名.方法
	 */
	public static Object invokeGetter(Object obj, String propertyName) {
		if (obj == null) {
			return obj;
		}
		if (obj instanceof Map) {
			return ((Map) obj).get(propertyName);
		}
		Object object = obj;
		for (String name : StringUtil.split(propertyName, StringUtil.DOT)) {
			object = ReflectUtil.invoke(object, GETTER_PREFIX + StringUtil.upperFirst(name));
		}
		return object;
	}

	/**
	 * 调用Setter方法, 仅匹配方法名。 支持多级，如：对象名.对象名.方法
	 */
	public static void invokeSetter(Object obj, String propertyName, Object value) {
		Object object = obj;
		List<String> names = StringUtil.split(propertyName, StringUtil.DOT);
		for (int i = 0, size = names.size(); i < size; i++) {
			if (i < size - 1) {
				object = ReflectUtil.invoke(object, GETTER_PREFIX + StringUtil.upperFirst(names.get(i)), value);
			} else {
				ReflectUtil.invoke(object, SETTER_PREFIX + StringUtil.upperFirst(names.get(i)), value);
			}
		}
	}

	/**
	 * 获取方法参数信息
	 *
	 * @param constructor    构造器
	 * @param parameterIndex 参数序号
	 * @return {MethodParameter}
	 */
	public MethodParameter getMethodParameter(Constructor<?> constructor, int parameterIndex) {
		MethodParameter methodParameter = new SynthesizingMethodParameter(constructor, parameterIndex);
		methodParameter.initParameterNameDiscovery(PARAMETERNAMEDISCOVERER);
		return methodParameter;
	}

	/**
	 * 获取方法参数信息
	 *
	 * @param method         方法
	 * @param parameterIndex 参数序号
	 * @return {MethodParameter}
	 */
	public MethodParameter getMethodParameter(Method method, int parameterIndex) {
		MethodParameter methodParameter = new SynthesizingMethodParameter(method, parameterIndex);
		methodParameter.initParameterNameDiscovery(PARAMETERNAMEDISCOVERER);
		return methodParameter;
	}

	/**
	 * 获取Annotation
	 *
	 * @param clazz
	 * @param pName
	 * @param annotationClass
	 * @param <A>
	 * @return
	 */
	public <A extends Annotation> A findAnnotation(Class<?> clazz, String pName, Class<A> annotationClass) {
		Class<?> temp = clazz;

		A an = null;
		while (an == null) {
			try {
				an = temp.getDeclaredField(pName).getAnnotation(annotationClass);
			} catch (Exception e) {
			}
			try {
				if (an == null) {
					an = temp.getDeclaredMethod(StringUtil.genGetter(pName)).getAnnotation(annotationClass);
				}
			} catch (Exception e) {
			}
			if (temp != null && !(temp.getClass().getName().equals(Object.class.getName()))) {
				temp = temp.getSuperclass();
			} else {
				break;
			}
		}

		return an;
	}

	/**
	 * 获取Annotation
	 *
	 * @param method         Method
	 * @param annotationType 注解类
	 * @param <A>            泛型标记
	 * @return {Annotation}
	 */
	public <A extends Annotation> A getAnnotation(Method method, Class<A> annotationType) {
		Class<?> targetClass = method.getDeclaringClass();
		// The method may be on an interface, but we need attributes from the target
		// class.
		// If the target class is null, the method will be unchanged.
		Method specificMethod = ClassUtil.getMostSpecificMethod(method, targetClass);
		// If we are dealing with method with generic parameters, find the original
		// method.
		specificMethod = BridgeMethodResolver.findBridgedMethod(specificMethod);
		// 先找方法，再找方法上的类
		A annotation = AnnotatedElementUtils.findMergedAnnotation(specificMethod, annotationType);
		if (null != annotation) {
			return annotation;
		}
		// 获取类上面的Annotation，可能包含组合注解，故采用spring的工具类
		return AnnotatedElementUtils.findMergedAnnotation(specificMethod.getDeclaringClass(), annotationType);
	}

	/**
	 * 获取Annotation
	 *
	 * @param handlerMethod  HandlerMethod
	 * @param annotationType 注解类
	 * @param <A>            泛型标记
	 * @return {Annotation}
	 */
	public <A extends Annotation> A getAnnotation(HandlerMethod handlerMethod, Class<A> annotationType) {
		// 先找方法，再找方法上的类
		A annotation = handlerMethod.getMethodAnnotation(annotationType);
		if (null != annotation) {
			return annotation;
		}
		// 获取类上面的Annotation，可能包含组合注解，故采用spring的工具类
		Class<?> beanType = handlerMethod.getBeanType();
		return AnnotatedElementUtils.findMergedAnnotation(beanType, annotationType);
	}

	/**
	 * 获取所有接口的实现类
	 *
	 * @return
	 */
	public static <T> List<Class<T>> getAllInterfaceAchieveClass(Class<T> clazz, String searchPackage) {
		ArrayList<Class<T>> list = new ArrayList<>();
		//判断是否是接口
		if (clazz.isInterface()) {
			try {
				ArrayList<Class> allClass = getAllClassByPath(searchPackage);
				/**
				 * 循环判断路径下的所有类是否实现了指定的接口
				 * 并且排除接口类自己
				 */
				for (int i = 0; i < allClass.size(); i++) {

					//排除抽象类
					if (Modifier.isAbstract(allClass.get(i).getModifiers())) {
						continue;
					}
					//判断是不是同一个接口
					if (clazz.isAssignableFrom(allClass.get(i))) {
						if (!clazz.equals(allClass.get(i))) {
							list.add(allClass.get(i));
						}
					}
				}
			} catch (Exception e) {
				System.out.println("出现异常");
			}
		}
		return list;
	}

	/**
	 * 从指定路径下获取所有类
	 *
	 * @return
	 */
	public static ArrayList<Class> getAllClassByPath(String packagename) {
		ArrayList<Class> list = new ArrayList<>();
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		String path = packagename.replace('.', '/');
		try {
			ArrayList<File> fileList = new ArrayList<>();
			Enumeration<URL> enumeration = classLoader.getResources(path);
			while (enumeration.hasMoreElements()) {
				URL url = enumeration.nextElement();
				fileList.add(new File(url.getFile()));
			}
			for (int i = 0; i < fileList.size(); i++) {
				list.addAll(findClass(fileList.get(i), packagename));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 如果file是文件夹，则递归调用findClass方法，或者文件夹下的类
	 * 如果file本身是类文件，则加入list中进行保存，并返回
	 *
	 * @param file
	 * @param packagename
	 * @return
	 */
	private static ArrayList<Class> findClass(File file, String packagename) {
		ArrayList<Class> list = new ArrayList<>();
		if (!file.exists()) {
			return list;
		}
		File[] files = file.listFiles();
		for (File file2 : files) {
			if (file2.isDirectory()) {
				//添加断言用于判断
				assert !file2.getName().contains(".");
				ArrayList<Class> arrayList = findClass(file2, packagename + "." + file2.getName());
				list.addAll(arrayList);
			} else if (file2.getName().endsWith(".class")) {
				try {
					//保存的类文件不需要后缀.class
					list.add(Class.forName(packagename + '.' + file2.getName().substring(0,
						file2.getName().length() - 6)));
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

}
