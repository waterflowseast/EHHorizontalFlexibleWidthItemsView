Pod::Spec.new do |s|
  s.name             = 'EHHorizontalFlexibleWidthItemsView'
  s.version          = '1.0.0'
  s.summary          = 'a view which arranges different-width item views one by one horizontally.'

  s.description      = <<-DESC
EHHorizontalFlexibleWidthItemsView: a view which arranges different-width item views one by one horizontally.
EHHorizontalFlexibleWidthItemsSeparatorView: EHHorizontalFlexibleWidthItemsView + separator lines.
EHHorizontalFlexibleWidthItemsSelectionView: selection version of EHHorizontalFlexibleWidthItemsView, you can single-select or multiple-select.
EHFlexibleWidthItemsSequentialSelectionView: sequentail selection version of EHHorizontalFlexibleWidthItemsView.
EHFlexibleWidthItemsSingleAnimatedSelectionView: a view which arranges different-width item views one by one horizontally, when you select one item, it automatically unselect the previous selected one with animation.
EHFlexibleWidthItemsSingleAnimatedSelectionSeparatorView: EHFlexibleWidthItemsSingleAnimatedSelectionView + separator lines.
                       DESC

  s.homepage         = 'https://github.com/waterflowseast/EHHorizontalFlexibleWidthItemsView'
  s.screenshots     = 'https://github.com/waterflowseast/EHHorizontalFlexibleWidthItemsView/raw/master/screenshots/1.png', 'https://github.com/waterflowseast/EHHorizontalFlexibleWidthItemsView/raw/master/screenshots/2.png', 'https://github.com/waterflowseast/EHHorizontalFlexibleWidthItemsView/raw/master/screenshots/3.png', 'https://github.com/waterflowseast/EHHorizontalFlexibleWidthItemsView/raw/master/screenshots/4.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eric Huang' => 'WaterFlowsEast@gmail.com' }
  s.source           = { :git => 'https://github.com/waterflowseast/EHHorizontalFlexibleWidthItemsView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'EHHorizontalFlexibleWidthItemsView/Classes/**/*'
  s.dependency 'EHItemViewCommon', '~> 1.0.0'
end
