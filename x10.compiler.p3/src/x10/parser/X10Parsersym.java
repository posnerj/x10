
//#line 18 "/Users/rmfuhrer/eclipse/workspaces/x10-refactoring-1.7-3.4/x10.compiler.p3/src/x10/parser/x10.g"
//
// Licensed Material
// (C) Copyright IBM Corp, 2006
//

package x10.parser;

public interface X10Parsersym {
    public final static int
      TK_IntegerLiteral = 79,
      TK_LongLiteral = 80,
      TK_FloatingPointLiteral = 81,
      TK_DoubleLiteral = 82,
      TK_CharacterLiteral = 83,
      TK_StringLiteral = 84,
      TK_MINUS_MINUS = 86,
      TK_OR = 110,
      TK_MINUS = 91,
      TK_MINUS_EQUAL = 124,
      TK_NOT = 93,
      TK_NOT_EQUAL = 111,
      TK_REMAINDER = 115,
      TK_REMAINDER_EQUAL = 125,
      TK_AND = 112,
      TK_AND_AND = 116,
      TK_AND_EQUAL = 126,
      TK_LPAREN = 1,
      TK_RPAREN = 75,
      TK_MULTIPLY = 113,
      TK_MULTIPLY_EQUAL = 127,
      TK_COMMA = 85,
      TK_DOT = 89,
      TK_DIVIDE = 117,
      TK_DIVIDE_EQUAL = 128,
      TK_COLON = 96,
      TK_SEMICOLON = 77,
      TK_QUESTION = 122,
      TK_AT = 2,
      TK_LBRACKET = 74,
      TK_RBRACKET = 102,
      TK_XOR = 114,
      TK_XOR_EQUAL = 129,
      TK_LBRACE = 90,
      TK_OR_OR = 121,
      TK_OR_EQUAL = 130,
      TK_RBRACE = 98,
      TK_TWIDDLE = 94,
      TK_PLUS = 92,
      TK_PLUS_PLUS = 87,
      TK_PLUS_EQUAL = 131,
      TK_LESS = 105,
      TK_LEFT_SHIFT = 118,
      TK_LEFT_SHIFT_EQUAL = 132,
      TK_RIGHT_SHIFT = 119,
      TK_RIGHT_SHIFT_EQUAL = 133,
      TK_UNSIGNED_RIGHT_SHIFT = 120,
      TK_UNSIGNED_RIGHT_SHIFT_EQUAL = 134,
      TK_LESS_EQUAL = 106,
      TK_EQUAL = 95,
      TK_EQUAL_EQUAL = 99,
      TK_GREATER = 107,
      TK_GREATER_EQUAL = 108,
      TK_ELLIPSIS = 137,
      TK_RANGE = 136,
      TK_ARROW = 88,
      TK_DARROW = 123,
      TK_SUBTYPE = 103,
      TK_SUPERTYPE = 104,
      TK_abstract = 7,
      TK_as = 28,
      TK_assert = 42,
      TK_async = 43,
      TK_at = 44,
      TK_ateach = 45,
      TK_atomic = 18,
      TK_await = 46,
      TK_break = 47,
      TK_case = 26,
      TK_catch = 31,
      TK_class = 14,
      TK_clocked = 32,
      TK_const = 48,
      TK_continue = 49,
      TK_def = 15,
      TK_default = 27,
      TK_do = 50,
      TK_else = 37,
      TK_extends = 33,
      TK_extern = 19,
      TK_false = 51,
      TK_final = 8,
      TK_finally = 34,
      TK_finish = 52,
      TK_for = 53,
      TK_foreach = 54,
      TK_future = 100,
      TK_in = 109,
      TK_goto = 55,
      TK_has = 56,
      TK_here = 57,
      TK_if = 58,
      TK_implements = 38,
      TK_import = 35,
      TK_incomplete = 20,
      TK_instanceof = 29,
      TK_interface = 11,
      TK_local = 21,
      TK_native = 16,
      TK_new = 59,
      TK_next = 60,
      TK_nonblocking = 22,
      TK_now = 61,
      TK_null = 62,
      TK_or = 39,
      TK_operator = 97,
      TK_package = 36,
      TK_private = 3,
      TK_property = 17,
      TK_protected = 4,
      TK_public = 5,
      TK_return = 63,
      TK_safe = 12,
      TK_self = 64,
      TK_sequential = 23,
      TK_shared = 30,
      TK_static = 6,
      TK_strictfp = 10,
      TK_super = 78,
      TK_switch = 65,
      TK_synchronized = 138,
      TK_this = 76,
      TK_throw = 66,
      TK_throws = 40,
      TK_transient = 24,
      TK_true = 67,
      TK_try = 68,
      TK_type = 9,
      TK_unsafe = 69,
      TK_val = 70,
      TK_value = 13,
      TK_var = 71,
      TK_volatile = 25,
      TK_when = 72,
      TK_while = 41,
      TK_EOF_TOKEN = 135,
      TK_IDENTIFIER = 73,
      TK_SlComment = 139,
      TK_MlComment = 140,
      TK_DocComment = 141,
      TK_ErrorId = 101,
      TK_ERROR_TOKEN = 142;

    public final static String orderedTerminalSymbols[] = {
                 "",
                 "LPAREN",
                 "AT",
                 "private",
                 "protected",
                 "public",
                 "static",
                 "abstract",
                 "final",
                 "type",
                 "strictfp",
                 "interface",
                 "safe",
                 "value",
                 "class",
                 "def",
                 "native",
                 "property",
                 "atomic",
                 "extern",
                 "incomplete",
                 "local",
                 "nonblocking",
                 "sequential",
                 "transient",
                 "volatile",
                 "case",
                 "default",
                 "as",
                 "instanceof",
                 "shared",
                 "catch",
                 "clocked",
                 "extends",
                 "finally",
                 "import",
                 "package",
                 "else",
                 "implements",
                 "or",
                 "throws",
                 "while",
                 "assert",
                 "async",
                 "at",
                 "ateach",
                 "await",
                 "break",
                 "const",
                 "continue",
                 "do",
                 "false",
                 "finish",
                 "for",
                 "foreach",
                 "goto",
                 "has",
                 "here",
                 "if",
                 "new",
                 "next",
                 "now",
                 "null",
                 "return",
                 "self",
                 "switch",
                 "throw",
                 "true",
                 "try",
                 "unsafe",
                 "val",
                 "var",
                 "when",
                 "IDENTIFIER",
                 "LBRACKET",
                 "RPAREN",
                 "this",
                 "SEMICOLON",
                 "super",
                 "IntegerLiteral",
                 "LongLiteral",
                 "FloatingPointLiteral",
                 "DoubleLiteral",
                 "CharacterLiteral",
                 "StringLiteral",
                 "COMMA",
                 "MINUS_MINUS",
                 "PLUS_PLUS",
                 "ARROW",
                 "DOT",
                 "LBRACE",
                 "MINUS",
                 "PLUS",
                 "NOT",
                 "TWIDDLE",
                 "EQUAL",
                 "COLON",
                 "operator",
                 "RBRACE",
                 "EQUAL_EQUAL",
                 "future",
                 "ErrorId",
                 "RBRACKET",
                 "SUBTYPE",
                 "SUPERTYPE",
                 "LESS",
                 "LESS_EQUAL",
                 "GREATER",
                 "GREATER_EQUAL",
                 "in",
                 "OR",
                 "NOT_EQUAL",
                 "AND",
                 "MULTIPLY",
                 "XOR",
                 "REMAINDER",
                 "AND_AND",
                 "DIVIDE",
                 "LEFT_SHIFT",
                 "RIGHT_SHIFT",
                 "UNSIGNED_RIGHT_SHIFT",
                 "OR_OR",
                 "QUESTION",
                 "DARROW",
                 "MINUS_EQUAL",
                 "REMAINDER_EQUAL",
                 "AND_EQUAL",
                 "MULTIPLY_EQUAL",
                 "DIVIDE_EQUAL",
                 "XOR_EQUAL",
                 "OR_EQUAL",
                 "PLUS_EQUAL",
                 "LEFT_SHIFT_EQUAL",
                 "RIGHT_SHIFT_EQUAL",
                 "UNSIGNED_RIGHT_SHIFT_EQUAL",
                 "EOF_TOKEN",
                 "RANGE",
                 "ELLIPSIS",
                 "synchronized",
                 "SlComment",
                 "MlComment",
                 "DocComment",
                 "ERROR_TOKEN"
             };

    public final static int numTokenKinds = orderedTerminalSymbols.length;
    public final static boolean isValidForParser = true;
}
