//Javascript cookie lib

// Get Cookie value with name params
//
// params cname [string] cookie name
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie).split(';');
    for(var index = 0; index < decodedCookie.length; index++) {
        var value = decodedCookie[index];
        while (value.charAt(0) == ' ') {
            value = value.substring(1);
        }
        if (value.indexOf(name) == 0) {
          if(value.substring(name.length, value.length) !== ''){
            return value.substring(name.length, value.length);
          }
        }
    }
    return '{}';
}
// Set Cookie value with key
//
// params cname [string] cookie name
// params cvalue [string] cookie value
// params exdays [date] expire days (Day unit)
function setCookie(cname,cvalue,exdays) {
    var date = new Date();
    date.setTime(date.getTime() + (exdays*24*60*60*1000));
    var expires = "expires=" + date.toGMTString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
