help([[
JupyterLab 3.6.3
]])
whatis("Name: JupyterLab")
whatis("Version: 3.6.3")
family("jupyter")

local root = "/opt/apps/jupyter/3.6.3"
prepend_path("PATH", pathJoin(root, "bin"))
