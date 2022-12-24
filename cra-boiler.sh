#! /bin/sh

# npx create-react-app <APP_NAME> --template cra-template-pwa

cd $1

cd public
rm favicon.ico
rm logo192.png
rm logo512.png

read -p "Enter title for index.html: " title 
read -p "Enter description for index.html: " desc 

sed -i "s/React App/$title/g" index.html
sed -i "s/Web site created using create-react-app/$desc/g" index.html

sed -i "s/Create React App Sample/$title/g" manifest.json
sed -i "s/React App/$title/g" manifest.json

cd ../src
> App.css
rm logo.svg
sed -i "s/serviceWorkerRegistration.unregister()/serviceWorkerRegistration.register()/g" index.js
> App.js

read -d '' appcontent << EOF
import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <h1>Hello World!</h1>
    </div>
  );
}

export default App;
EOF

echo $appcontent >> App.js

cd ..
echo '.env' >> .gitignore

code .