// require - Add the contents of a file to current
// require_self - Change order of where current contents are concatenated to current
// require_directory - Add contents of each file in a folder to current
// require_tree - Add contents of all files in all directories in a path to current
// link - Make target file compile and be publicly available without adding contents to current
// link_directory - Make target directory compile and be publicly available without adding contents to current
// link_tree - Make target tree compile and be publicly available without adding contents to current
// depend_on - Recompile current file if target has changed
// stub - Ignore target file

// Application may need to be linked to.
//= link_tree ../images
//= link_directory ../stylesheets .css
