console.log('yes');

function callDeleteAPI(url) {
    const ajax = new XMLHttpRequest();

    ajax.open('DELETE', url);
   
    ajax.onreadystatechange = function () {
        var DONE = 4; // readyState 4 means the request is done.
        var OK = 200; // status 200 is a successful return.
        if (ajax.readyState === DONE) {
          if (ajax.status === OK) 
            location.reload();
          else
            alert(ajax.responseText);
        }
      };

    ajax.send();
}

function deleteBeing(id) {

    return callDeleteAPI('/beings/' + id);
}

function deletePantheon(id) {
    return callDeleteAPI('/pantheons/' + id);
}

function deleteMetaPantheon(id) {
    return callDeleteAPI('/meta-pantheons/' + id);
}

function deleteIntraPantheon(id) {
    return callDeleteAPI('/ipas/' + id);
}

function deleteCharacteristics(id) {
    return callDeleteAPI('/chars/' + id);
}