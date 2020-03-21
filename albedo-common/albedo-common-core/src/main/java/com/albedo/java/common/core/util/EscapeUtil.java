package com.albedo.java.common.core.util;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;

public class EscapeUtil extends cn.hutool.core.util.EscapeUtil {

	/**
	 * <p>Escapes the characters in a <code>String</code> using HTML entities.</p>
	 *
	 * <p>
	 * For example:
	 * </p>
	 * <p><code>"bread" & "butter"</code></p>
	 * becomes:
	 * <p>
	 * <code>&amp;quot;bread&amp;quot; &amp;amp; &amp;quot;butter&amp;quot;</code>.
	 * </p>
	 *
	 * <p>Supports all known HTML 4.0 entities, including funky accents.
	 * Note that the commonly used apostrophe escape character (&amp;apos;)
	 * is not a legal entity and so is not supported). </p>
	 *
	 * @param str  the <code>String</code> to escape, may be null
	 * @return a new escaped <code>String</code>, <code>null</code> if null string input
	 *
	 * @see #unescapeHtml(String)
	 * @see <a href="http://hotwired.lycos.com/webmonkey/reference/special_characters/">ISO Entities</a>
	 * @see <a href="http://www.w3.org/TR/REC-html32#latin1">HTML 3.2 Character Entities for ISO Latin-1</a>
	 * @see <a href="http://www.w3.org/TR/REC-html40/sgml/entities.html">HTML 4.0 Character entity references</a>
	 * @see <a href="http://www.w3.org/TR/html401/charset.html#h-5.3">HTML 4.01 Character References</a>
	 * @see <a href="http://www.w3.org/TR/html401/charset.html#code-position">HTML 4.01 Code positions</a>
	 */
	public static String escapeHtml(String str) {
		if (str == null) {
			return null;
		}
		try {
			StringWriter writer = new StringWriter ((int)(str.length() * 1.5));
			escapeHtml(writer, str);
			return writer.toString();
		} catch (IOException ioe) {
			//should be impossible
			throw new RuntimeException(ioe);
		}
	}

	/**
	 * <p>Escapes the characters in a <code>String</code> using HTML entities and writes
	 * them to a <code>Writer</code>.</p>
	 *
	 * <p>
	 * For example:
	 * </p>
	 * <code>"bread" & "butter"</code>
	 * <p>becomes:</p>
	 * <code>&amp;quot;bread&amp;quot; &amp;amp; &amp;quot;butter&amp;quot;</code>.
	 *
	 * <p>Supports all known HTML 4.0 entities, including funky accents.
	 * Note that the commonly used apostrophe escape character (&amp;apos;)
	 * is not a legal entity and so is not supported). </p>
	 *
	 * @param writer  the writer receiving the escaped string, not null
	 * @param string  the <code>String</code> to escape, may be null
	 * @throws IllegalArgumentException if the writer is null
	 * @throws IOException when <code>Writer</code> passed throws the exception from
	 *                                       calls to the {@link Writer#write(int)} methods.
	 *
	 * @see #escapeHtml(String)
	 * @see #unescapeHtml(String)
	 * @see <a href="http://hotwired.lycos.com/webmonkey/reference/special_characters/">ISO Entities</a>
	 * @see <a href="http://www.w3.org/TR/REC-html32#latin1">HTML 3.2 Character Entities for ISO Latin-1</a>
	 * @see <a href="http://www.w3.org/TR/REC-html40/sgml/entities.html">HTML 4.0 Character entity references</a>
	 * @see <a href="http://www.w3.org/TR/html401/charset.html#h-5.3">HTML 4.01 Character References</a>
	 * @see <a href="http://www.w3.org/TR/html401/charset.html#code-position">HTML 4.01 Code positions</a>
	 */
	public static void escapeHtml(Writer writer, String string) throws IOException {
		if (writer == null ) {
			throw new IllegalArgumentException ("The Writer must not be null.");
		}
		if (string == null) {
			return;
		}
		Entities.HTML40.escape(writer, string);
	}

	//-----------------------------------------------------------------------
	/**
	 * <p>Unescapes a string containing entity escapes to a string
	 * containing the actual Unicode characters corresponding to the
	 * escapes. Supports HTML 4.0 entities.</p>
	 *
	 * <p>For example, the string "&amp;lt;Fran&amp;ccedil;ais&amp;gt;"
	 * will become "&lt;Fran&ccedil;ais&gt;"</p>
	 *
	 * <p>If an entity is unrecognized, it is left alone, and inserted
	 * verbatim into the result string. e.g. "&amp;gt;&amp;zzzz;x" will
	 * become "&gt;&amp;zzzz;x".</p>
	 *
	 * @param str  the <code>String</code> to unescape, may be null
	 * @return a new unescaped <code>String</code>, <code>null</code> if null string input
	 * @see #escapeHtml(Writer, String)
	 */
	public static String unescapeHtml(String str) {
		if (str == null) {
			return null;
		}
		try {
			StringWriter writer = new StringWriter ((int)(str.length() * 1.5));
			unescapeHtml(writer, str);
			return writer.toString();
		} catch (IOException ioe) {
			//should be impossible
			throw new RuntimeException(ioe);
		}
	}

	/**
	 * <p>Unescapes a string containing entity escapes to a string
	 * containing the actual Unicode characters corresponding to the
	 * escapes. Supports HTML 4.0 entities.</p>
	 *
	 * <p>For example, the string "&amp;lt;Fran&amp;ccedil;ais&amp;gt;"
	 * will become "&lt;Fran&ccedil;ais&gt;"</p>
	 *
	 * <p>If an entity is unrecognized, it is left alone, and inserted
	 * verbatim into the result string. e.g. "&amp;gt;&amp;zzzz;x" will
	 * become "&gt;&amp;zzzz;x".</p>
	 *
	 * @param writer  the writer receiving the unescaped string, not null
	 * @param string  the <code>String</code> to unescape, may be null
	 * @throws IllegalArgumentException if the writer is null
	 * @throws IOException if an IOException occurs
	 * @see #escapeHtml(String)
	 */
	public static void unescapeHtml(Writer writer, String string) throws IOException {
		if (writer == null ) {
			throw new IllegalArgumentException ("The Writer must not be null.");
		}
		if (string == null) {
			return;
		}
		Entities.HTML40.unescape(writer, string);
	}

}
