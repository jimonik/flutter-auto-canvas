enum WidgetType {
  line(name: "直线"),
  curve(name: "曲线"),
  circle(name: "圆形"),
  elliptic(name: "椭圆"), //要有旋转
  nAngle(name: "N边形"), //要有旋转
  ;

  final String name;
  const WidgetType({required this.name});
}
