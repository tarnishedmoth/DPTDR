class_name TextUtils extends RefCounted

static func ital(v) -> String: return "[i]" + str(v) + "[/i]"
static func bold(v) -> String: return "[b]" + str(v) + "[/b]"
static func underl(v) -> String: return "[u]" + str(v) + "[/u]"
static func brac(v) -> String: return "[" + str(v) + "]"
