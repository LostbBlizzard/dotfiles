---@param input string
---@param output string
return function(input, output)
	local tarfile = output .. ".tar.gz"

	local shellscript =
	"find ./ ! -name \"*.sh\" -type f | xargs -i bash -c \"mkdir -p $(basename {})-out && mv $(basename {}) $(basename {}).gz.tar && tar -xzvf $(basename {}).gz.tar -C $(basename {})-out && git clone $(basename {})-out $(basename {}) && rm $(basename {}).gz.tar && rm -rf $(basename {})-out\""

	local file = io.open(input .. "/unpack.sh", "w")
	if file == nil then
		return
	end
	file:write(shellscript)
	file:close()

	os.execute("cd $(dirname " .. output .. ") && tar -czf " .. tarfile .. " " .. "backup")


	os.execute("rm -rf " .. input)
end
