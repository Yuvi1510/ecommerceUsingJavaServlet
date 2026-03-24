function changeContent(contentId){
    const element = document.getElementById("inner-content");

    if(contentId === "add"){
        element.innerHTML = `
    
       <form action="/categories" method="post">
       <input name="action" value="add" hidden>
       <div>
    <h2>Add Category</h2>
    </div>
                    <div>
                        <label for="name">Name: </label>
                        <input type="text" name="name" id="name" >
                    </div>
                    <div>
                    <button type="submit">Add</button>
                    <button class="btn-danger" onclick="changeContent('list')">Cancel</button>
               
                    </div>
                     </form>`;
    }
}

function edit(categoryId, categoryName){
        document.getElementById("inner-content").innerHTML = `
    
       <form action="/categories" method="post">
       <input name="action" value="edit" hidden>
       <div>
    <h2>Edit Category</h2>
    </div>
                    <div>
                        <label for="id">Category Id: </label>
                        <input type="text" name="id" id="id" value="${categoryId}" hidden>
                    </div>
                    <div>
                        <label for="name">Name: </label>
                        <input type="text" name="name" id="name" value="${categoryName}">
                    </div>
                    <div>
                    <button type="submit">Update</button>
                    <button class="btn-danger" ><a href="/categories">Cancel</a></button>
               
                    </div>
                     </form>`;

}

function deleteCategory(categoryId, categoryName){

    document.getElementById("inner-content").innerHTML = `
       <form action="/categories" method="post">
       <input name="action" value="delete" hidden>
                    <div>
                        <label for="id">Category Id: </label>
                        <input type="text" name="id" id="id" value="${categoryId}" hidden>
                    </div>
                    <div>
                        <label for="name">Name: </label>
                        <input type="text" name="name" id="name" value="${categoryName}" disabled>
                    </div>
                    <div>
                    <button type="submit" class="btn-danger">Delete</button>
                    <button ><a href="/categories">Cancel</a></button>
                    </div>
                </form>`;

}