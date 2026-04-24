sealed class ExploreIntent {}

class LoadSubjectsIntent extends ExploreIntent {}

class FilterSubjectsIntent extends ExploreIntent {
  final String subject;
  FilterSubjectsIntent(this.subject);
}
