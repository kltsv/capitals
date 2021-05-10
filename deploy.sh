## Updates Github Pages web demo by force-pushing example/build/web directory to gh-pages branch

PACKAGE_NAME=$(echo "${PWD##*/}")

# Build
echo "Build demo"
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true

# Prepare
echo "Save current repo configs"
REPO_REMOTE_URL=$(git remote get-url origin)
REPO_NAME=$(echo "${REPO_REMOTE_URL##*/}")
REPO_NAME=$(echo "${REPO_NAME%.git}")
REPO_USER_NAME=$(git config user.name)
REPO_USER_EMAIL=$(git config user.email)
echo "Go to a script working directory"
cd build
echo "Create a directory for web repo"
mkdir $REPO_NAME
cd $REPO_NAME

# Pull repo gh-pages
echo "Init a repo"
git init
echo "Setting user config"
git config user.name $REPO_USER_NAME
git config user.email $REPO_USER_EMAIL
echo "Attach it to our repo remote url"
git remote add origin $REPO_REMOTE_URL
echo "Create branch gh-pages that will store web demo"
git checkout -b gh-pages
echo "Fetching current state of web demo"
git pull origin gh-pages

# Copy a new web demo
echo "Remove previous version of web demo"
rm -rf $PACKAGE_NAME
cd ..
echo "Copy web source code to a web demo directory"
cp -r web $REPO_NAME
mv $REPO_NAME/web $REPO_NAME/$PACKAGE_NAME
cd $REPO_NAME

# Force-push updated demo
echo "Clear git history"
rm -rf .git
git init
git remote add origin $REPO_REMOTE_URL
git checkout -b gh-pages
echo "Commit and push an update"
git add --all
git commit -m "$REPO_USER_NAME has updated $PACKAGE_NAME at $(date +%Y.%m.%d.%H:%M:%S)"
git push -f origin gh-pages

# Clear
echo "Remove temporary repo"
cd ..
rm -rf $REPO_NAME
echo "Back to root directory"
cd ..
echo "Clear repo variables"
unset REPO_REMOTE_URL
unset REPO_NAME
unset PACKAGE_NAME
unset REPO_USER_EMAIL
unset REPO_USER_NAME
echo "Web demo successfully published"