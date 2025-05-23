Pod::Spec.new do |spec|
  spec.name = 'SomaiOS'
  spec.version = '1.4.0'
  spec.summary = 'XP Inc. Design system library.'
  spec.homepage = 'https://xpinvestimentos.visualstudio.com/Projetos/_git/SomaiOS'
  spec.author = { 'Design.Ops' => "design.ops@xpi.com.br" }
  spec.license = { :type => 'private' }
  spec.source = { :git => 'https://xpinvestimentos.visualstudio.com/Projetos/_git/SomaiOS',
                  :tag => spec.version.to_s }

  spec.ios.deployment_target = '11.0'
  spec.requires_arc = true

  spec.cocoapods_version = '>= 1.5'
  spec.swift_version = '5.0'

  spec.default_subspec = 'Core'

  spec.subspec 'Core' do |base|
    base.source_files = [
      'SomaiOS/Classes/RenderProtocol.swift',
      'SomaiOS/Classes/Base/**/*.{h,m,swift}',
      'SomaiOS/Classes/Fonts/**/*.{h,m,swift}',
      'SomaiOS/Classes/SomaTheme/SomaTheme.swift',
      'SomaiOS/Tokens/**/*.{h,m,swift}',
      'SomaiOS/Classes/Components/Typography/**/*.{h,m,swift}',
      'SomaiOS/Classes/Components/Skeleton/**/*.{swift}',
      'SomaiOS/Classes/Components/Spacing/**/*.{swift}',
      'SomaiOS/Classes/Components/Shared/**/*.{swift}',
      'SomaiOS/Generated/**/*.{swift}'
    ]

    base.resources = [
      'SomaiOS/SupportingFiles/Fonts/*/*.{ttf}',
      'SomaiOS/Tokens/**/*.{json}',
      'SomaiOS/SupportingFiles/Assets/*.{xcassets}',
      'SomaiOS/SupportingFiles/**/*.strings'
    ]
    base.dependency 'Shimmer'
    base.dependency 'SomaiOS/SomaUtils'
    base.dependency 'UtilsCore'
    base.dependency 'SomaiOSAssets'
  end

  spec.subspec 'ActivityIndicator' do |activityIndicator|
    activityIndicator.source_files = ['SomaiOS/Classes/Components/ActivityIndicator/**/*.{swift}']
    activityIndicator.dependency 'SomaiOS/Buttons'
  end

  spec.subspec 'Alert' do |alert|
    alert.source_files = ['SomaiOS/Classes/Components/Alert/**/*.{swift, xib}']
    alert.dependency 'SomaiOS/Core'
    alert.dependency 'SomaiOS/ActivityIndicator'
  end

  spec.subspec 'Analytics' do |analytics|
    analytics.source_files = ['SomaiOS/SomaiOS/Classes/Analytics/**/*.{swift}']
    analytics.dependency 'XPCore/ThirdParties'
    analytics.dependency 'SomaiOS/Core'
  end

  spec.subspec 'AssetCard' do |assetCard|
    assetCard.source_files = 'SomaiOS/Classes/Components/AssetCard/**/*.{swift, xib}'
    assetCard.dependency 'SomaiOS/Core'
    assetCard.dependency 'SomaiOS/Buttons'
  end

  spec.subspec 'AvatarSquare' do |avatarSquare|
    avatarSquare.source_files = 'SomaiOS/Classes/Components/Avatar/AvatarSquare/**/*.{swift, xib}' 
    avatarSquare.resources = 'SomaiOS/Classes/Components/Avatar/AvatarSquare/**/*.xib' 
    avatarSquare.dependency 'SomaiOS/Core'
  end

  spec.subspec 'Avatars' do |avatars|
    avatars.source_files = 'SomaiOS/Classes/Components/Avatar/**/*.{swift, xib}' 
    avatars.resources = 'SomaiOS/Classes/Components/Avatar/**/*.xib' 
    avatars.dependency 'SomaiOS/Core'
  end

  spec.subspec 'BannerExpandableLink' do |bannerExpandableLink|
    bannerExpandableLink.source_files = ['SomaiOS/Classes/Components/BannerExpandableLink/**/*.{swift, xib}']
    bannerExpandableLink.dependency 'SomaiOS/Core'
  end

  spec.subspec 'BannerHero' do |bannerHero|
    bannerHero.source_files = 'SomaiOS/Classes/Components/Banner/BannerHero/**/*.{swift, xib}' 
    bannerHero.resources = 'SomaiOS/Classes/Components/Banner/BannerHero/**/*.xib' 
    bannerHero.dependency 'SomaiOS/Core'
  end
  
  spec.subspec 'Banners' do |banners| 
    banners.source_files = ['SomaiOS/Classes/Components/Banner/**/*.{swift, xib}']
    banners.dependency 'SomaiOS/Core'
  end

  spec.subspec 'BottomBar' do |bottomBar|
    bottomBar.source_files = ['SomaiOS/Classes/Components/TabBar/**/*.{swift, xib}',
                          'SomaiOS/Classes/Components/BottomSheet/**/*.{swift, xib}']
    bottomBar.dependency 'SomaiOS/Core'
  end

  spec.subspec 'BottomSheet' do |bottomSheet|
    bottomSheet.source_files = ['SomaiOS/Classes/Components/BottomSheet/**/*.{swift, xib}']
    bottomSheet.dependency 'SomaiOS/Core'
  end

  spec.subspec 'Buttons' do |buttons|
    buttons.source_files = 'SomaiOS/Classes/Components/Button/**/*.{swift}'
    buttons.dependency 'SomaiOS/Core'
  end

  spec.subspec 'CardRisk' do |card|
    card.source_files = ['SomaiOS/Classes/Components/CardRisk/**/*.{swift, xib}',
                          'SomaiOS/Classes/Components/Dialog/Theme/SomaDialogThemeProtocol.swift']
    card.dependency 'SomaiOS/Core'
    card.dependency 'SomaiOS/ActivityIndicator'
  end

  spec.subspec 'Cards' do |cards|
    cards.source_files = 'SomaiOS/Classes/Components/Card/**/*.{swift, xib}'
    cards.dependency 'SomaiOS/Core'
    cards.dependency 'SomaiOS/Buttons'
    cards.dependency 'SomaiOS/ChartCircular'
    cards.resources = 'SomaiOS/Classes/Components/Card/**/*.xib'
  end

  spec.subspec 'Cells' do |cell|
    cell.source_files = 'SomaiOS/Classes/Components/Cells/**/*.{swift, xib}'
    cell.dependency 'SomaiOS/CompoundButtons'
    cell.dependency 'SomaiOS/Buttons'
    cell.resources = 'SomaiOS/Classes/Components/Cells/**/*.xib'
  end

  spec.subspec 'ChartCircular' do |chartCircular|
    chartCircular.source_files = ['SomaiOS/Classes/Components/Chart/**/*.{swift}']
    chartCircular.dependency 'SomaiOS/Core'
  end

  spec.subspec 'ChatInput' do |chatInput|
    chatInput.source_files = 'SomaiOS/Classes/Components/ChatInput/**/*.swift'
    chatInput.dependency 'SomaiOS/Core'
    chatInput.dependency 'SomaiOS/Buttons'
  end

  spec.subspec 'Checklist' do |checklist|
    checklist.source_files = ['SomaiOS/Classes/Components/Checklist/**/*.{swift}']
    checklist.dependency 'SomaiOS/Core'
  end

  spec.subspec 'CompoundButtons' do |compound_buttons|
    compound_buttons.source_files = ['SomaiOS/Classes/Components/Checkbox/**/*.{h,m,swift, xib}',
                                    'SomaiOS/Classes/Components/Switch/**/*.{h,m,swift, xib}',
                                    'SomaiOS/Classes/Components/RadioButton/**/*.{h,m,swift, xib}']
    compound_buttons.dependency 'SomaiOS/Core'
  end

  spec.subspec 'Dialog' do |dialog|
    dialog.source_files = ['SomaiOS/Classes/Components/Dialog/**/*.{swift}']
    dialog.dependency 'SomaiOS/Core'
    dialog.dependency 'SomaiOS/ActivityIndicator'
  end

  spec.subspec 'InputBankPassword' do |inputBankPassword|
    inputBankPassword.source_files = ['SomaiOS/Classes/Components/InputBankPassword/**/*.{swift}']
    inputBankPassword.dependency 'SomaiOS/Buttons'
    inputBankPassword.dependency 'SomaiOS/PasswordField'
    inputBankPassword.dependency 'SomaiOS/ActivityIndicator'
  end

  spec.subspec 'InputQuantity' do |inputQuantity|
    inputQuantity.source_files = 'SomaiOS/Classes/Components/InputUnits/**/*.{swift, xib}'
    inputQuantity.dependency 'SomaiOS/Core'
    inputQuantity.dependency 'SomaiOS/Buttons'
    inputQuantity.resources = 'SomaiOS/Classes/Components/InputUnits/**/*.xib'
  end

  spec.subspec 'InputTransaction' do |inputTransaction|
    inputTransaction.source_files = ['SomaiOS/Classes/Components/InputTransaction/**/*.{swift, xib}',
                                     'SomaiOS/Classes/Components/InputTransactions/Utils/**/*.{swift, xib}']
    inputTransaction.dependency 'SomaiOS/Buttons'
  end

  spec.subspec 'InputTransactions' do |inputTransactions|
    inputTransactions.source_files = ['SomaiOS/Classes/Components/InputTransactions/**/*.{swift, xib}']
    inputTransactions.dependency 'SomaiOS/Buttons'
  end

  spec.subspec 'Modal' do |modal|
    modal.source_files = ['SomaiOS/Classes/Components/Modal/**/*.{swift}']
    modal.dependency 'SomaiOS/Core'
  end

  spec.subspec 'PasswordField' do |passwordField|
    passwordField.source_files = ['SomaiOS/Classes/Components/PasswordFieldComponent/**/*.{swift, xib}']
    passwordField.resources = 'SomaiOS/Classes/Components/PasswordFieldComponent/**/*.xib'
    passwordField.dependency 'SomaiOS/Buttons'
  end

  spec.subspec 'Search' do |search|
    search.source_files = ['SomaiOS/Classes/Components/SomaSearch/**/*.{swift}']
    search.dependency 'SomaiOS/Core'
  end

  spec.subspec 'Shortcuts' do |shortcut|
    shortcut.source_files = [
      'SomaiOS/Classes/Components/Shortcut/**/*.{swift, xib}',
    ]
    shortcut.dependency 'SomaiOS/Core'
    shortcut.resources = 'SomaiOS/Classes/Components/Shortcut/Legacy/CollectionViewCells/ShortcutCollectionViewCell.xib'
  end

  spec.subspec 'Slider' do |slider|
    slider.source_files = ['SomaiOS/Classes/Components/Slider/**/*.{swift}']
    slider.dependency 'SomaiOS/Core'
  end

  spec.subspec 'SomaComponentError' do |component|
    component.source_files = ['SomaiOS/Classes/Components/SomaComponentError/**/*.{swift}']
    component.dependency 'SomaiOS/Core'
  end

  spec.subspec 'SomaUtils' do |utils|
    utils.source_files = [
      'SomaiOS/SomaUtils/**/*.{h,m,swift}',
      'SomaiOS/Generated/**/*.{swift}'
    ]
  end

  spec.subspec 'Stepper' do |stepper|
    stepper.source_files = 'SomaiOS/Classes/Components/Stepper/**/*.{swift, xib}'
    stepper.dependency 'SomaiOS/Core'
    stepper.dependency 'SomaiOS/Buttons'
    stepper.resources = 'SomaiOS/Classes/Components/Stepper/**/*.xib'
  end

  spec.subspec 'SwitchText' do |switchText|
    switchText.source_files = ['SomaiOS/Classes/Components/SomaSwitchText/**/*.{swift, xib}']
    switchText.dependency 'SomaiOS/Core'
  end

  spec.subspec 'TabView' do |tabView|
    tabView.source_files = ['SomaiOS/Classes/Components/TabView/**/*.{swift, xib}']
    tabView.dependency 'SomaiOS/Core'
    tabView.dependency 'Parchment'
  end

  spec.subspec 'TagFilter' do |tag|
    tag.source_files = ['SomaiOS/Classes/Components/TagFilter/**/*.{swift, xib}',
                        'SomaiOS/Classes/Components/TagFilterWithSearchBar/**/*.{swift, xib}']
    tag.dependency 'SomaiOS/Core'
    tag.resources = ['SomaiOS/Classes/Components/TagFilter/**/*.xib',
                    'SomaiOS/Classes/Components/TagFilterWithSearchBar/**/*.xib']
  end

  spec.subspec 'TestUtils' do |tests|
    tests.source_files = ['SomaiOSTests/TestUtils/**/*.{h,m,swift}']
    tests.weak_framework = 'XCTest'
    
    #Dependencies
    tests.dependency 'SnapshotTesting', '~> 1.9.0'
    tests.dependency 'SomaiOS/Core'
    tests.dependency 'UtilsCore'
    tests.dependency 'TestUtils'
  end

  spec.subspec 'TextField' do |textField|
    textField.source_files = ['SomaiOS/Classes/Components/Search/**/*.{swift, xib}',
                              'SomaiOS/Classes/Components/TextField/**/*.{swift, xib}']

    textField.resources = 'SomaiOS/Classes/Components/Search/**/*.xib'
    textField.dependency 'SomaiOS/Core'
  end

  spec.subspec 'Tooltip' do |tooltip|
    tooltip.source_files = ['SomaiOS/Classes/Components/Tooltip/**/*.{swift}']
    tooltip.dependency 'SomaiOS/Core'
  end

  spec.subspec 'TopBar' do |topBar|
    topBar.source_files = ['SomaiOS/Classes/Components/NavigationBar/**/*.{swift, xib}']
    topBar.dependency 'SomaiOS/Core'
  end

  spec.subspec 'TopBarProgress' do |topBarProgress|
    topBarProgress.source_files = ['SomaiOS/Classes/Components/TopBarProgress/**/*.{swift}']
    topBarProgress.dependency 'SomaiOS/Core'
  end
  
end 
