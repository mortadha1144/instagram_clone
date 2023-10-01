import 'package:instagram_clone/views/components/animations/lottie_animation_view.dart';
import 'package:instagram_clone/views/components/animations/models/lottie_animation.dart';

class LoadingAnimtionView extends LottieAnimationView {
  const LoadingAnimtionView({
    super.key,
  }) : super(
          animation: LottieAnimation.loading,
        );
}