# Print the current working directory, shortened to fit the prompt
function global:pshazz:prompt_pwd:prompt {
	$global:pshazz.prompt_vars.path = (pwd).path.replace("$ENV:USERPROFILE", "~") -replace "(\.?[^\\]{$fish_prompt_pwd_dir_length})[^\\]*\\", '$1\'
}