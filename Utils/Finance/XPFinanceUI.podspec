Pod::Spec.new do |spec|

  spec.name = 'XPFinanceUI'
  spec.version = '2.1.6'
  spec.summary = 'SDK de UI para servicos financeiros.'
  spec.homepage = 'http://www.xpi.com.br'

  spec.ios.deployment_target = '11.0'
  spec.swift_version = '5.0'

  spec.license = {
    :type => 'Private'
  }

  spec.author = {
    'Wagner Sales' => 'wagner.sales@xpi.com.br',
    'Ismael Ussefatt' => 'ismael.ussefatt@xpi.com.br',
    'Fabio Nogueira' => 'fabio.nogueira@xpi.com.br'
  }

  spec.source = {
    :git => 'https://xpinvestimentos.visualstudio.com/Projetos/_git/XPInc.FinanceUI.iOS',
    :tag => 'XPFinanceUI-' + spec.version.to_s 
  }

  ##### Subspec Core
  spec.default_subspec = 'Core'
  spec.dependency 'XPCore'
  spec.dependency 'XPuzzle'
  
  spec.subspec 'Core' do |core|
    base_dir = "XPFinanceUI/"
    core.source_files = [
      base_dir + 'Sources/**/*.{h,m,swift}',
      base_dir + 'Generated/**/*.{h,m,swift}'
    ]

    core.resources = [
      base_dir + '**/*.xcassets',
      base_dir + '**/*.strings'
    ]

    core.resource_bundles = {
      'XPFinanceUI' => [
        base_dir + '**/*.xib',
        base_dir + '**/*.storyboard',
        base_dir + '**/*.json'
      ]
    }

    # Cocoapods
    core.dependency 'lottie-ios'

    ## Soma
    core.dependency 'SomaiOSAssets'
    core.dependency 'SomaiOS/Alert'
    core.dependency 'SomaiOS/Banners'
    core.dependency 'SomaiOS/BottomBar'
    core.dependency 'SomaiOS/BottomSheet'
    core.dependency 'SomaiOS/Buttons'
    core.dependency 'SomaiOS/Cards'
    core.dependency 'SomaiOS/Cells'
    core.dependency 'SomaiOS/CompoundButtons'
    core.dependency 'SomaiOS/Core'
    core.dependency 'SomaiOS/Dialog'
    core.dependency 'SomaiOS/InputTransaction'
    core.dependency 'SomaiOS/Shortcuts'
    core.dependency 'SomaiOS/SomaUtils'
    core.dependency 'SomaiOS/TabView'
    core.dependency 'SomaiOS/TagFilter'
    core.dependency 'SomaiOS/TextField'
    core.dependency 'SomaiOS/TopBar'
    core.dependency 'SomaiOS/TopBarProgress'

    ## Corporate
    core.dependency 'XPComponents'
    core.dependency 'EletronicSignature'
    core.dependency 'EyeManager'
    core.dependency 'DeeplinkCore/Features'
    core.dependency 'SelfTableViewManager'
    core.dependency 'SomaiOSXP'
    core.dependency 'XPCommons'
    core.dependency 'XPFacialBiometricsiOS'
    core.dependency 'XPFacialBiometricsInterface'
    core.dependency 'OTPTokenCodeInterface'

    # Banner
    core.dependency 'XPBanner'
    core.dependency 'XPBanner/HelpFlow'

    ## UtilsCore
    core.dependency 'UtilsCore'

    ## Core
    core.dependency 'XPCore/AppGlobalIntegrationDeeplink'
    core.dependency 'XPCore/DigitalAccountService'
    core.dependency 'XPCore/Reusable'
    core.dependency 'XPCore/ThirdParties'
    core.dependency 'ThirdPartiesCore'
    core.dependency 'AnalyticsCore'
    core.dependency 'SerializationCore'
    core.dependency 'MyPortfolioServiceInterface'

    ## Foundation
    core.dependency 'DependencyInjector'

    ## Network
    core.dependency 'XPLoginService'
    core.dependency 'NetworkCore'

    # Finance
    core.dependency 'XPBarcode'
    core.dependency 'XPFinance'
    core.dependency 'XPFinanceInterface'
    
    # XPFacialBiometricsiOS
    core.dependency 'XPFacialBiometricsiOS'
    core.dependency 'XPFacialBiometricsInterface'

    # WLAntifraud
    core.dependency 'WLAntifraudInterface'

    # WLWhatsNew    
    core.dependency 'WLWhatsNewInterface'

    # BilletConsulting 
    core.dependency 'BilletConsultingInterface'
  end
end
