let btnSelectImages = document.getElementById("upload-file_input");
let preview = document.getElementById("preview");
let btnSubmit = document.getElementById("upload-submit");

/* events */
btnSelectImages.onchange = renderImagePreviews;

function renderImagePreviews(event) {
    btnSelectImages.files = null;
    preview.innerHTML = "";
    
    let template = document.getElementById('preview-template');
    
    for(let i = 0; i < btnSelectImages.files.length; i++) {        
        let file = btnSelectImages.files[i];
        let img_src = URL.createObjectURL(file);

        let newPreview = template.cloneNode(true);
        newPreview.id = '';
        
        newPreview.querySelectorAll(".action-item")[0].onclick = setParent;
        newPreview.querySelectorAll(".action-item")[1].onclick = delPreviewImage;

        newPreview.querySelector('.img').src = img_src;

        preview.appendChild(newPreview);
    }

    btnSubmit.disabled = false;
}

function delPreviewImage(event) {
    let index = getActionParentIndex(event);
    removeFile(index);
    renderImagePreviews();
}

function setParent(event) {
    let index = getActionParentIndex(event);
    console.log(event);

    swapFiles(index, 0);

    console.log({
        f1: btnSelectImages.files[index],
        f2: btnSelectImages.files[0]
    })
    renderImagePreviews();
}

// /* copied from https://stackoverflow.com/questions/16943605/remove-a-filelist-item-from-a-multiple-inputfile */
function removeFile(index){
    let attachments = btnSelectImages.files; // <-- reference your file input here
    let fileBuffer = new DataTransfer();

    // append the file list to an array iteratively
    for (let i = 0; i < attachments.length; i++) {
        // Exclude file in specified index
        if (index !== i)
            fileBuffer.items.add(attachments[i]);
    }
    
    // Assign buffer to file input
    btnSelectImages.files = fileBuffer.files; // <-- according to your file input reference
}

function swapFiles(a, b) {
    var attachments = btnSelectImages.files;
    var fileBuffer = new DataTransfer();
    
    let fileA = attachments[a];
    let fileB = attachments[b];

    for (let i = 0; i < attachments.length; i++) {
        if (i == a)
            fileBuffer.items.add(fileB);
        else if (i == b)
            fileBuffer.items.add(fileA);
        else
            fileBuffer.items.add(attachments[i]);
    }
    btnSelectImages.files = fileBuffer.files;
}

function getActionParentIndex(event) {
    let parent = null;

    for (const element of event.path) {
        console.log(element.classList)
        if (element.classList.contains('preview-image')) {
            parent = element;
            break;
        }
    }

    let parentsParent = parent.parentElement;
    let index = -1;
    for (let i = 0; i < parentsParent.childNodes.length; i++) {
        if (parentsParent.childNodes[i] == parent) {
            index = i;
            break;
        }
    }
    return index;
}
