help([[
JupyterLab 4.0.9
]])
whatis("Name: JupyterLab")
whatis("Version: 4.0.9")
family("jupyter")

local root = "/opt/apps/jupyter/4.0.9"
prepend_path("PATH", pathJoin(root, "bin"))
