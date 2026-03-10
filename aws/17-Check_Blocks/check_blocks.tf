/*data "http" "example" {
      url = "https://jmarcelocarvalho.com"
  }
  
resource "local_file" "foo" {
  content  = "Hi"
  filename = "${path.module}/website_check.txt"
}
*/

check "website_checker" {
   data "http" "check_site" {
      url = "https://jmarcelocarvalho81.com"
   }

   assert {
     condition = data.http.check_site.status_code == 200
     error_message = "Website is not running. Please check"
   }
}

resource "local_file" "output" {
  content  = "Hello, this is Marcelo's website"
  filename = "${path.module}/output.txt"

}