class ValidationMixin{

  String? validateTask(String? value) {
    if (value!.isEmpty){
      return "Please provide the title";
    }else{
      return null;
    }
  }

  String? validateDescription(String? value) {
  if (value!.isEmpty){
    return "Please provide the description.";
  }else{
    return null;
    }
  }


}