class_name GRDConstants extends RefCounted


## 获取本地化字符串
static func translate(string: String) -> String:
	var locale: String = TranslationServer.get_tool_locale()
	if _current_translation == null or _current_locale != locale:
		var base_path: String = new().get_script().resource_path.get_base_dir()
		var translation_path: String = "%s/l10n/%s.po" % [base_path, locale]
		var fallback_translation_path: String = "%s/l10n/%s.po" % [base_path, locale.substr(0, 2)]
		var en_translation_path: String = "%s/l10n/en.po" % base_path
		_current_translation = load(translation_path if FileAccess.file_exists(translation_path) else (fallback_translation_path if FileAccess.file_exists(fallback_translation_path) else en_translation_path))
		_current_locale = locale
		_en_translation = load(en_translation_path)
	var message: StringName = _current_translation.get_message(string)
	if not message.is_empty():
		return message
	elif not _en_translation.get_message(string).is_empty():
		return _en_translation.get_message(string)
	else:
		return string


static var _current_translation: Translation = null
static var _current_locale: String = ""
static var _en_translation: Translation = null
