---@param project string
---@param projectsettings {type:string}
---@param output string
return function(project, projectsettings, output)
	if projectsettings.type == "git" then
		print("backing up " .. project .. " to " .. output)

		local tepdir = output .. "_tep"

		os.execute("git clone --bare " .. project .. " " .. tepdir)

		os.execute("rm -rf " .. output)
		os.execute("cd " .. tepdir .. " && tar -czf " .. output .. " " .. ".")

		os.execute("rm -rf " .. tepdir)
	end
end
