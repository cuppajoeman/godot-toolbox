
#static func snake_case_to_camel_case(camel_case: String) -> String
	#just lowercase the first word of the title case
	
static func snake_case_to_title_case(snake_case: String) -> String:
	var title_case: String = ""
	var words = snake_case.split("_")
	for word in words:
		title_case += capitalize_word(word)
	return title_case

static func capitalize_word(word: String) -> String:
	return word[0].to_upper() + word.substr(1,-1)
	
static func lowercase_word(word: String) -> String:
	return word.to_lower()

static func snake_case_to_space_separated_title_case(snake_case: String) -> String:
	var title_case: String = ""
	var lowercase_words = snake_case.split("_")
	var capitalized_words = []
	for lowercase_word in lowercase_words:
		capitalized_words.append(capitalize_word(lowercase_word))
	return " ".join(capitalized_words)
	
static func space_separated_title_case_to_snake_case(space_separated_title_case: String) -> String:
	var capitalized_words = space_separated_title_case.split(" ")
	#var lowercase_words = capitalized_words.map(lowercase_word)
	var lowercase_words = []
	for capitalized_word in capitalized_words:
		lowercase_words.append(lowercase_word(capitalized_word))
	return "_".join(lowercase_words)

	#return "_".join(
	#	space_separated_title_case.split(" ").map(lowercase_word)
	#)
