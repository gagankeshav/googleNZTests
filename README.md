Please refer below-mentioned notes regarding the test script:
1. Google does not provide public Search API's but only CSE API's i.e. the custom search engine API's that can be consumed and used in tests. Hence, I have used a non-conventional method of using the URL instead of API endpoints to perform the search.
2. All the test scenario's that I outlined cannot be automated from API perspective. Hence, I have automated some critical cases to validate functionality.

Please refer below-mentioned steps to execute the tests:
Pre-requisites:
Ruby should be installed on the system.
Chromedriver should be downloaded on the system and placed in one of the directories in the PATH variable.

Once ensured that ruby is indeed installed on the system, we need to install the dependent gems for the test script on the system using the below-mentioned commands, one after the other:

gem install rest-client
gem install selenium-webdriver
gem install rspec

Once the above commands have executed successfully, navigate to the folder where the script has been downloaded in the windows explorer, click in the URL bar of the window, type cmd and hit enter to open a command prompt window at the downloaded location.

Use the below-mentioned command to execute the tests:
rspec Google_Tests.rb --format documentation

Please note that I have refrained from implementation of proper POM and RSpec formatting structure due to lack of time for completion of the test. Given sufficient time, I can share a sample of code that I have on GitHub under my account that depicts a similar approach with using POM but no testing tool such as RSpec.

Please feel free to get in touch with me regarding any queries on the above.
