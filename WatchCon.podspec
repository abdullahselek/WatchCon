Pod::Spec.new do |s|

    s.name                  = 'WatchCon'
    s.version               = '0.1'
    s.summary               = 'WatchCon is a tool which enables creating easy connectivity between iOS and WatchOS'
    s.homepage              = 'https://github.com/abdullahselek/WatchCon'
    s.license               = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author                = {
        'Abdullah Selek' => 'abdullahselek@yahoo.com'
    }
    s.source                = {
        :git => 'https://github.com/abdullahselek/WatchCon.git',
        :tag => s.version.to_s
    }
    s.ios.deployment_target = '9.0'
    s.watchos.deployment_target = '2.0'
    s.source_files          = 'Sources/*.{h,m}'
    s.requires_arc          = true

end