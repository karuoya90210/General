
function GetDocumentBase64(DocumentValue){

document.getElementById("controlAddIn")
                        .insertAdjacentHTML('beforeend','<iframe id="myPDF" width="100%" height="500" src="data:application/pdf;base64,'+
                        DocumentValue
                                    +'" />');
}