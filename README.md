# Bakerastic iOS
==========================

## Initial Setup ##

1. Install [RVM](https://rvm.io/)
2. Install [Bundler](http://bundler.io/) `gem install bundler`
3. Clone the repo
4. Go to the file directory of Bakerastic
5. Install project gems `bundle install`
6. Install pod dependencies: `bundle exec pod install`
7. Open the CocoaPods workspace file: `Bakerastic.xcworkspace`
8. You're good to go! 

## Additional Info ##
- Project has automatically generated UI constants with SBConstants gem. See build phases.


## Troubleshooting ##
If Xcode build fails due this error
```
The sandbox is not in sync with the Podfile.lock
```

Install pods with following command (this will happen if a library is added or removed from Podfile)
```
pod install
```
