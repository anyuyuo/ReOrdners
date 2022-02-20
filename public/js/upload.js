let btnSelectImages = document.getElementById("upload-file_input");
let preview = document.getElementById("preview");
let btnSubmit = document.getElementById("upload-submit");

/* events */
btnSelectImages.onchange = renderImagePreviews;

function renderImagePreviews(event) {
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
        actions.classList.add("actions", "p-sm", "center-content");
        actions.innerHTML = `<button class="btn">*</button>
            <button class="btn ml">del</button>`;

        let img = document.createElement("img");
        img.classList.add("img");
        img.src = img_src;

        image.appendChild(actions);
        image.appendChild(img);
        preview.appendChild(image);
    }

    btnSubmit.disabled = false;
}