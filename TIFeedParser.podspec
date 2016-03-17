Pod::Spec.new do |s|
  s.name = 'TIFeedParser'
  s.version = '1.0'
  s.license = 'MIT'
  s.summary = 'TIFeedParser is an parser for RSS, built on Alamofire and AEXML.'
  s.homepage = 'https://github.com/tichise/TIFeedParser'
  s.social_media_url = 'http://twitter.com/tichise'
  s.author = "Takuya Ichise"
  s.source = { :git => 'https://github.com/tichise/TIFeedParser.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/*.swift'
  s.requires_arc = true
  
  spec.dependency 'AEXML'
  spec.dependency 'Alamofire'

end