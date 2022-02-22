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
        image.classList.add("preview-image", "center-content", "m");

        let actions = document.createElement("div");
        let btnActionSetParent = document.createElement("button");
        let btnActionDeleteImage = document.createElement("button");

        actions.classList.add("actions", "p-sm", "center-content");

        // Todo: set proper icons as values
        btnActionSetParent.textContent = "*";
        btnActionSetParent.classList.add("btn")

        btnActionDeleteImage.textContent = "-";
        btnActionDeleteImage.attributes.index = i;
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

    btnSubmit.disabled = false;
}

function delPreviewImage(event) {
    console.log(event.target.attributes.index)
}
