#
# Be sure to run `pod lib lint BaseMVC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'BaseMVC'
    s.version          = '0.1.5'
    s.summary          = 'A short description of BaseMVC.'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC

    s.homepage         = 'https://github.com/DaoPinWong/BaseMVC'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'DaoPinWong' => '413655409@qq.com' }
    s.source           = { :git => 'https://github.com/DaoPinWong/BaseMVC.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = 'BaseMVC/Classes/**/*'

    # s.resource_bundles = {
    #   'BaseMVC' => ['BaseMVC/Assets/*.png']
    # }

    s.requires_arc = true

    non_arc_files = 'BaseMVC/Classes/Component/NSObjectSafe/*.{h,m}'

    s.exclude_files = non_arc_files

    s.subspec 'no-arc' do |sp|

        sp.source_files = non_arc_files

        sp.requires_arc = false

    end

    s.subspec 'Categories' do |sCategories|

        sCategories.source_files = 'BaseMVC/Classes/Categories/*.{h,m}'

    end

    s.subspec 'Component' do |sComponent|

        sComponent.source_files = 'BaseMVC/Classes/Component/*.{h,m}'

    end

    s.subspec 'Controller' do |sController|

        sController.source_files = 'BaseMVC/Classes/Controller/*.{h,m}'

    end

    s.subspec 'Model' do |sModel|

        sModel.source_files = 'BaseMVC/Classes/Model/*.{h,m}'

    end

    s.subspec 'View' do |sView|

        sView.source_files = 'BaseMVC/Classes/View/*.{h,m}'

    end




    # s.requires_arc = false

    # s.requires_arc = ['BaseMVC/Classes/Component/NSObjectSafe/*.{h,m}']



    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'DPNetworking'
    s.dependency 'Masonry'
    s.dependency 'MBProgressHUD'
    s.dependency 'MJRefresh'
    s.dependency 'MJExtension'

end

