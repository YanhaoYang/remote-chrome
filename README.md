# Run Rails system tests in remote Chrome

1. `git clone https://github.com/YanhaoYang/remote-chrome.git tmp/remote-chrome`
2. `. tmp/remote-chrome/chrome.sh`
3. On remote host: `java -jar selenium-server-standalone-3.14.0.jar`
4. `rspec -fd --fail-fast -r $PWD/tmp/remote-chrome/rails_helper.rb ./spec/system/some_spec.rb`
