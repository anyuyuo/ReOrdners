let btnSelectImages = document.getElementById("upload-file_input");
let preview = document.getElementById("preview");
let btnSubmit = document.getElementById("upload-submit");

/* events */
btnSelectImages.onchange = renderImagePreviews;

function renderImagePreviews(event) {
    btnSelectImages.files = null;
    preview.innerHTML = "";
    
    /*
        Template:
        <div class="preview-image center-content">
            <div class="actions p-sm center-content">
                <button class="btn">*</button>
                <button class="btn ml">del</button>
            </div>
            <img src="/uploads/1.jpg" class="img" />
        </div>
    */
    for(let i = 0; i < btnSelectImages.files.length; i++) {
        let file = btnSelectImages.files[i];
        let img_src = URL.createObjectURL(file);
        
        /* create html elements according to template*/
        let image = document.createElement("div");
        image.attributes.index = i;
        image.classList.add("preview-image", "center-content", "m");

        let actions = document.createElement("div");
        let btnActionSetParent = document.createElement("button");
        let btnActionDeleteImage = document.createElement("button");

        actions.classList.add("actions", "p-sm", "center-content");

        // Todo: set proper icons as values
        btnActionSetParent.textContent = "*";
        btnActionSetParent.classList.add("btn", "action-parent")
        btnActionSetParent.onclick = setParent;

        btnActionDeleteImage.textContent = "-";
        btnActionDeleteImage.classList.add("btn", "ml");
        btnActionDeleteImage.onclick = delPreviewImage;

        actions.appendChild(btnActionSetParent);
        actions.appendChild(btnActionDeleteImage);

        let img = document.createElement("img");
        img.classList.add("img");
        img.src = img_src;

        image.appendChild(actions);
        image.appendChild(img);
        preview.appendChild(image);
    }

    preview.querySelector('.action-parent').classList.add("starred");

    btnSubmit.disabled = false;
}

function delPreviewImage(event) {
    let index = getActionParentIndex(event.target);
    removeFile(index);
    renderImagePreviews();
}

function setParent(event) {
    let index = getActionParentIndex(event.target);
    console.log({
        index,
        f1: btnSelectImages.files[index],
        f2: btnSelectImages.files[0]
    })

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

function getActionParentIndex(actionElement) {
    let parent = actionElement.parentElement.parentElement;
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
