import 'package:instagram_clone/views/components/animations/lottie_animation_view.dart';
import 'package:instagram_clone/views/components/animations/models/lottie_animation.dart';

class EmptyContetnAnimationView extends LottieAnimationView {
  const EmptyContetnAnimationView({
    super.key,
  }) : super(
          animation: LottieAnimation.empty,
        );
}
