if next(SMODS.find_mod("Cryptid")) then return nil else
local ace = { 
	admin,
}
		G.FUNCS.text_input_key = function(args)
			local pasting_clipboard = G.CONTROLLER.pasting_clipboard or false
			args = args or {}
			if pasting_clipboard == false then
				-- Ctrl+V clipboard paste support
				local is_ctrl = false
				if G.CONTROLLER and G.CONTROLLER.held_keys then
					is_ctrl = G.CONTROLLER.held_keys["lctrl"]
						or G.CONTROLLER.held_keys["rctrl"]
						or G.CONTROLLER.held_keys["lgui"]
						or G.CONTROLLER.held_keys["rgui"]
				end
				if not is_ctrl and love.keyboard then
					is_ctrl = love.keyboard.isDown("lctrl", "rctrl", "lgui", "rgui")
				end
				if args and (args.key == "v" or args.key == "V") and is_ctrl then
					local clipboard = (
						G.F_LOCAL_CLIPBOARD and G.CLIPBOARD or (love.system and love.system.getClipboardText())
					) or ""
					if type(clipboard) == "string" and clipboard ~= "" and G.CONTROLLER.text_input_hook then
						G.CONTROLLER.pasting_clipboard = true
						for i = 1, #clipboard do
							local c = clipboard:sub(i, i)
							G.FUNCS.text_input_key({ key = c })
						end
						G.CONTROLLER.pasting_clipboard = false
						return
					end
				end
				-- Ctrl+V supported
			end
			local hook = G.CONTROLLER.text_input_hook
			if not hook.config.ref_table.extended_corpus then
				if args.key == "[" or args.key == "]" then
					return
				end
				if args.key == "0" then
					args.key = "o"
				end
			else
				if string.byte(args.key, 1) >= 128 then
					print(string.byte(args.key, 1))
					args.key = "?" --fix for lovely bugging out
				end
			end

			--shortcut to hook config
			local hook_config = G.CONTROLLER.text_input_hook.config.ref_table
			hook_config.orig_colour = hook_config.orig_colour or copy_table(hook_config.colour)

			args.key = args.key or "%"
			--capitalize if caps lock or hook requires
			args.caps = args.caps or G.CONTROLLER.capslock or hook_config.all_caps

			--Some special keys need to be mapped accordingly before passing through the corpus
			local keymap = {
				space = " ",
				backspace = "BACKSPACE",
				delete = "DELETE",
				["return"] = "RETURN",
				right = "RIGHT",
				left = "LEFT",
			}
			local corpus = "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
				.. (hook.config.ref_table.extended_corpus and " 0!$&()<>?:{}+-=,.[]_" or "")

			if hook.config.ref_table.extended_corpus then
				local lower_ext = [[1234567890-=;',./]]
				local upper_ext = [[!@#$%^&*()_+:"<>?]]
				if args.caps then
					if args.key == "." then
						args.key = ">"
					end
					if args.key == "[" then
						args.key = "{"
					end
					if args.key == "]" then
						args.key = "}"
					end
					if args.key == "\\" then
						args.key = "|"
					end
				end

				pcall(function()
					if string.find(lower_ext, args.key) and args.caps then
						args.key = string.sub(string.sub(upper_ext, string.find(lower_ext, args.key)), 0, 1)
					end
				end)
			end
			local text = hook_config.text

			--set key to mapped key or upper if caps is true
			args.key = keymap[args.key] or (args.caps and string.upper(args.key) or args.key)

			--Start by setting the cursor position to the correct location
			TRANSPOSE_TEXT_INPUT(0)

			if string.len(text.ref_table[text.ref_value]) > 0 and args.key == "BACKSPACE" then --If not at start, remove preceding letter
				MODIFY_TEXT_INPUT({
					letter = "",
					text_table = text,
					pos = text.current_position,
					delete = true,
				})
				TRANSPOSE_TEXT_INPUT(-1)
			elseif string.len(text.ref_table[text.ref_value]) > 0 and args.key == "DELETE" then --if not at end, remove following letter
				MODIFY_TEXT_INPUT({
					letter = "",
					text_table = text,
					pos = text.current_position + 1,
					delete = true,
				})
				TRANSPOSE_TEXT_INPUT(0)
			elseif args.key == "RETURN" then --Release the hook
				if hook.config.ref_table.callback then
					hook.config.ref_table.callback()
				end
				hook.parent.parent.config.colour = hook_config.colour
				local temp_colour = copy_table(hook_config.orig_colour)
				hook_config.colour[1] = G.C.WHITE[1]
				hook_config.colour[2] = G.C.WHITE[2]
				hook_config.colour[3] = G.C.WHITE[3]
				ease_colour(hook_config.colour, temp_colour)
				G.CONTROLLER.text_input_hook = nil
			elseif args.key == "LEFT" then --Move cursor position to the left
				TRANSPOSE_TEXT_INPUT(-1)
			elseif args.key == "RIGHT" then --Move cursor position to the right
				TRANSPOSE_TEXT_INPUT(1)
			elseif
				hook_config.max_length > string.len(text.ref_table[text.ref_value])
				and (string.len(args.key) == 1)
				and (string.find(corpus, args.key, 1, true) or hook.config.ref_table.extended_corpus)
			then --check to make sure the key is in the valid corpus, add it to the string
				MODIFY_TEXT_INPUT({
					letter = args.key,
					text_table = text,
					pos = text.current_position + 1,
				})
				TRANSPOSE_TEXT_INPUT(1)
			end
		end
		local yc = G.FUNCS.your_collection
		G.FUNCS.your_collection = function(e)
			if G.CHOOSE_CARD then
				G.CHOOSE_CARD:remove()
				G.CHOOSE_CARD = nil
			end
			yc(e)
		end
		items = ace
	end