from django.http import HttpResponse

def hello(request):
    return HttpResponse("Hello, world! This is the starter Django app.")
