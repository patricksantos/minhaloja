import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../presentation_layer/components/opacity_animation.dart';
import '../../presentation_layer/components/scale_animation.dart';
import '../../presentation_layer/components/default_button.dart';
import '../../presentation_layer/components/sliver_flexible_scroll.dart';

import 'package:quickfood/infra/infra.dart';

class FeedbackResultPage extends StatelessWidget {
  final String titleAppBar;
  final String title;
  final String? message;
  final String? buttonTitle;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Widget? content;

  const FeedbackResultPage({
    super.key,
    required this.title,
    required this.titleAppBar,
    this.onPressed,
    this.icon,
    this.message,
    this.content,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    const duration = Duration(seconds: 1);

    return Container(
      decoration: BoxDecoration(
        color: design.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * .75,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          backgroundColor: design.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 70.height,
            centerTitle: true,
            title: Text(
              titleAppBar,
              style: design
                  .h5(color: design.secondary100)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            leading: Container(
              padding: EdgeInsets.only(
                left: 10.width,
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onPressed ?? Modular.to.pop,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.height),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: design.secondary100,
                            textDirection: TextDirection.rtl,
                            size: 26.fontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SliverFlexibleScroll(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const Spacer(),
                if (icon == null)
                  ScaleAnimation(
                    duration: duration,
                    child: Icon(
                      Icons.check_circle_outline_outlined,
                      color: design.primary300,
                      size: 100,
                    ),
                  ),
                if (icon != null) ScaleAnimation(child: icon!),
                SizedBox(
                  height: 20.height,
                ),
                OpacityAnimation(
                  duration: duration,
                  child: Text(
                    title,
                    style: design.h3(color: design.secondary100),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10.height,
                ),
                if (message != null)
                  OpacityAnimation(
                    duration: duration,
                    child: Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: design.paragraphS(color: design.secondary300),
                    ),
                  ).addPadding(
                    EdgeInsets.symmetric(horizontal: 15.width),
                  ),
                if (content != null) OpacityAnimation(child: content!),
                const Spacer(),
                SizedBox(
                  height: 16.height,
                ),
                DefaultButton(
                  label: buttonTitle ?? 'Continuar',
                  onPressed: () {
                    if (onPressed != null) {
                      onPressed?.call();
                    } else {
                      Modular.to.pop();
                    }
                  },
                ).safeArea()
              ],
            ).addPadding(
              const EdgeInsets.all(20),
            ),
          ),
        ),
      ),
    );
  }
}
