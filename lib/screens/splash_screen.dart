import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class ThreeDotsWaveLoader extends StatefulWidget {
  final Color dotColor;
  final double dotSize;
  final Duration animationDuration;
  final double waveHeight;

  const ThreeDotsWaveLoader({
    Key? key,
    this.dotColor = Colors.white,
    this.dotSize = 10.0,
    this.animationDuration = const Duration(milliseconds: 600),
    this.waveHeight = 10.0,
  }) : super(key: key);

  @override
  _ThreeDotsWaveLoaderState createState() => _ThreeDotsWaveLoaderState();
}

class _ThreeDotsWaveLoaderState extends State<ThreeDotsWaveLoader> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat();
    _animation1 = Tween(begin: 0.0, end: widget.waveHeight).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeInOut),
    );

    _controller2 = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat();
    _animation2 = Tween(begin: 0.0, end: widget.waveHeight).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.easeInOut),
    );

    _controller3 = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat();
    _animation3 = Tween(begin: 0.0, end: widget.waveHeight).animate(
      CurvedAnimation(parent: _controller3, curve: Curves.easeInOut),
    );

    _controller1.addListener(() {
      if (_controller1.status == AnimationStatus.completed) {
        _controller1.reverse();
      } else if (_controller1.status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _controller1.forward();
        });
      }
    });

    _controller2.addListener(() {
      if (_controller2.status == AnimationStatus.completed) {
        _controller2.reverse();
      } else if (_controller2.status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(milliseconds: 100), () { 
          _controller2.forward();
        });
      }
    });

    _controller3.addListener(() {
      if (_controller3.status == AnimationStatus.completed) {
        _controller3.reverse();
      } else if (_controller3.status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(milliseconds: 200), () { 
          _controller3.forward();
        });
      }
    });

    // Start animations
    _controller1.forward();
    Future.delayed(const Duration(milliseconds: 100), () => _controller2.forward());
    Future.delayed(const Duration(milliseconds: 200), () => _controller3.forward());
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Widget _buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: widget.dotSize,
          width: widget.dotSize,
          decoration: BoxDecoration(
            color: widget.dotColor,
            shape: BoxShape.circle,
          ),
          transform: Matrix4.translationValues(0.0, -animation.value, 0.0),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildDot(_animation1),
        _buildDot(_animation2),
        _buildDot(_animation3),
      ],
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkLoginStatus();

    await Future.delayed(Duration(seconds: 3)); 

    if (authProvider.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade200, 
              Colors.purple.shade400, 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withOpacity(0.9),
                child: Icon(
                  Icons.shopping_bag_outlined, 
                  size: 70,
                  color: Colors.purple.shade700, 
                ),
              ),
              SizedBox(height: 24), 
              Text(
                'Smart Shop',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8), 
              Text(
                'Your Ultimate Shopping Destination',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 48), 
              ThreeDotsWaveLoader(
                dotColor: Colors.white,
                dotSize: 10.0,
                waveHeight: 10.0,
                animationDuration: Duration(milliseconds: 600),
              ),
              SizedBox(height: 16),
           
            ],
          ),
        ),
      ),
    );
  }
}
