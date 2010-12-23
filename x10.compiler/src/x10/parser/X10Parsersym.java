/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2010.
 */
/*****************************************************
 * WARNING!  THIS IS A GENERATED FILE.  DO NOT EDIT! *
 *****************************************************/

package x10.parser;

public interface X10Parsersym {
    public final static int
      TK_IntegerLiteral = 13,
      TK_LongLiteral = 14,
      TK_FloatingPointLiteral = 15,
      TK_DoubleLiteral = 16,
      TK_CharacterLiteral = 17,
      TK_StringLiteral = 18,
      TK_MINUS_MINUS = 33,
      TK_OR = 76,
      TK_MINUS = 31,
      TK_MINUS_EQUAL = 86,
      TK_NOT = 36,
      TK_NOT_EQUAL = 77,
      TK_REMAINDER = 69,
      TK_REMAINDER_EQUAL = 87,
      TK_AND = 78,
      TK_AND_AND = 85,
      TK_AND_EQUAL = 88,
      TK_LPAREN = 1,
      TK_RPAREN = 7,
      TK_MULTIPLY = 68,
      TK_MULTIPLY_EQUAL = 89,
      TK_COMMA = 11,
      TK_DOT = 30,
      TK_DIVIDE = 70,
      TK_DIVIDE_EQUAL = 90,
      TK_COLON = 42,
      TK_SEMICOLON = 8,
      TK_QUESTION = 100,
      TK_AT = 6,
      TK_LBRACKET = 2,
      TK_RBRACKET = 37,
      TK_XOR = 79,
      TK_XOR_EQUAL = 91,
      TK_LBRACE = 38,
      TK_OR_OR = 92,
      TK_OR_EQUAL = 93,
      TK_RBRACE = 39,
      TK_TWIDDLE = 40,
      TK_PLUS = 32,
      TK_PLUS_PLUS = 34,
      TK_PLUS_EQUAL = 94,
      TK_LESS = 71,
      TK_LEFT_SHIFT = 61,
      TK_LEFT_SHIFT_EQUAL = 95,
      TK_RIGHT_SHIFT = 62,
      TK_RIGHT_SHIFT_EQUAL = 96,
      TK_UNSIGNED_RIGHT_SHIFT = 63,
      TK_UNSIGNED_RIGHT_SHIFT_EQUAL = 97,
      TK_LESS_EQUAL = 72,
      TK_EQUAL = 35,
      TK_EQUAL_EQUAL = 59,
      TK_GREATER = 73,
      TK_GREATER_EQUAL = 74,
      TK_ELLIPSIS = 129,
      TK_RANGE = 75,
      TK_ARROW = 66,
      TK_DARROW = 105,
      TK_SUBTYPE = 46,
      TK_SUPERTYPE = 80,
      TK_abstract = 49,
      TK_as = 101,
      TK_assert = 115,
      TK_async = 106,
      TK_at = 45,
      TK_ateach = 107,
      TK_atomic = 47,
      TK_break = 116,
      TK_case = 81,
      TK_catch = 108,
      TK_class = 48,
      TK_clocked = 43,
      TK_continue = 117,
      TK_def = 109,
      TK_default = 82,
      TK_do = 110,
      TK_else = 118,
      TK_extends = 111,
      TK_false = 19,
      TK_final = 50,
      TK_finally = 112,
      TK_finish = 44,
      TK_for = 113,
      TK_goto = 130,
      TK_haszero = 83,
      TK_here = 20,
      TK_if = 119,
      TK_implements = 120,
      TK_import = 84,
      TK_in = 67,
      TK_instanceof = 98,
      TK_interface = 102,
      TK_native = 51,
      TK_new = 10,
      TK_next = 3,
      TK_null = 21,
      TK_offer = 121,
      TK_offers = 122,
      TK_operator = 123,
      TK_package = 114,
      TK_private = 52,
      TK_property = 103,
      TK_protected = 53,
      TK_public = 54,
      TK_resume = 4,
      TK_return = 124,
      TK_self = 22,
      TK_static = 55,
      TK_struct = 64,
      TK_super = 12,
      TK_switch = 125,
      TK_this = 9,
      TK_throw = 126,
      TK_transient = 56,
      TK_true = 23,
      TK_try = 127,
      TK_type = 65,
      TK_val = 57,
      TK_var = 58,
      TK_void = 41,
      TK_when = 128,
      TK_while = 104,
      TK_EOF_TOKEN = 99,
      TK_IDENTIFIER = 5,
      TK_SlComment = 131,
      TK_MlComment = 132,
      TK_DocComment = 133,
      TK_ByteLiteral = 24,
      TK_ShortLiteral = 25,
      TK_UnsignedIntegerLiteral = 26,
      TK_UnsignedLongLiteral = 27,
      TK_UnsignedByteLiteral = 28,
      TK_UnsignedShortLiteral = 29,
      TK_PseudoDoubleLiteral = 134,
      TK_ErrorId = 60,
      TK_ERROR_TOKEN = 135;

    public final static String orderedTerminalSymbols[] = {
                 "",
                 "LPAREN",
                 "LBRACKET",
                 "next",
                 "resume",
                 "IDENTIFIER",
                 "AT",
                 "RPAREN",
                 "SEMICOLON",
                 "this",
                 "new",
                 "COMMA",
                 "super",
                 "IntegerLiteral",
                 "LongLiteral",
                 "FloatingPointLiteral",
                 "DoubleLiteral",
                 "CharacterLiteral",
                 "StringLiteral",
                 "false",
                 "here",
                 "null",
                 "self",
                 "true",
                 "ByteLiteral",
                 "ShortLiteral",
                 "UnsignedIntegerLiteral",
                 "UnsignedLongLiteral",
                 "UnsignedByteLiteral",
                 "UnsignedShortLiteral",
                 "DOT",
                 "MINUS",
                 "PLUS",
                 "MINUS_MINUS",
                 "PLUS_PLUS",
                 "EQUAL",
                 "NOT",
                 "RBRACKET",
                 "LBRACE",
                 "RBRACE",
                 "TWIDDLE",
                 "void",
                 "COLON",
                 "clocked",
                 "finish",
                 "at",
                 "SUBTYPE",
                 "atomic",
                 "class",
                 "abstract",
                 "final",
                 "native",
                 "private",
                 "protected",
                 "public",
                 "static",
                 "transient",
                 "val",
                 "var",
                 "EQUAL_EQUAL",
                 "ErrorId",
                 "LEFT_SHIFT",
                 "RIGHT_SHIFT",
                 "UNSIGNED_RIGHT_SHIFT",
                 "struct",
                 "type",
                 "ARROW",
                 "in",
                 "MULTIPLY",
                 "REMAINDER",
                 "DIVIDE",
                 "LESS",
                 "LESS_EQUAL",
                 "GREATER",
                 "GREATER_EQUAL",
                 "RANGE",
                 "OR",
                 "NOT_EQUAL",
                 "AND",
                 "XOR",
                 "SUPERTYPE",
                 "case",
                 "default",
                 "haszero",
                 "import",
                 "AND_AND",
                 "MINUS_EQUAL",
                 "REMAINDER_EQUAL",
                 "AND_EQUAL",
                 "MULTIPLY_EQUAL",
                 "DIVIDE_EQUAL",
                 "XOR_EQUAL",
                 "OR_OR",
                 "OR_EQUAL",
                 "PLUS_EQUAL",
                 "LEFT_SHIFT_EQUAL",
                 "RIGHT_SHIFT_EQUAL",
                 "UNSIGNED_RIGHT_SHIFT_EQUAL",
                 "instanceof",
                 "EOF_TOKEN",
                 "QUESTION",
                 "as",
                 "interface",
                 "property",
                 "while",
                 "DARROW",
                 "async",
                 "ateach",
                 "catch",
                 "def",
                 "do",
                 "extends",
                 "finally",
                 "for",
                 "package",
                 "assert",
                 "break",
                 "continue",
                 "else",
                 "if",
                 "implements",
                 "offer",
                 "offers",
                 "operator",
                 "return",
                 "switch",
                 "throw",
                 "try",
                 "when",
                 "ELLIPSIS",
                 "goto",
                 "SlComment",
                 "MlComment",
                 "DocComment",
                 "PseudoDoubleLiteral",
                 "ERROR_TOKEN"
             };

    public final static int numTokenKinds = orderedTerminalSymbols.length;
    public final static boolean isValidForParser = true;
}
