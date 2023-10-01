import 'package:instagram_clone/views/components/animations/lottie_animation_view.dart';
import 'package:instagram_clone/views/components/animations/models/lottie_animation.dart';

class ErrorAnimtionView extends LottieAnimationView {
  const ErrorAnimtionView({
    super.key,
  }) : super(
          animation: LottieAnimation.error,
        );
}