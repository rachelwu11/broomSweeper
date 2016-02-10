# broomSweeper
**It's a shell script to remove unused images from iOS project**

##Why?
When you keep work on the same project for years, probably you'll find the size of your project is very large, and you want to "squeeze" it. Remove redundant images might be the first thing you consider about it. 

##How?
General idea is, *iterate every image in the project, check each one been called in the project or not, if so, keep it; otherwise, delete it both from* **project.pbxproj** *and* **repository**.

##Notes:eyes:
Delete 2x images from repo using command line is little different for Git and SVN, use *hello_world@2x.png* as an example
for SVN:
```
svn delete hello_world@2x.png@  //has @ at the end
git rm -f "hello_world@2x.png"  //-f to force removal; --cached to keep the file
```


