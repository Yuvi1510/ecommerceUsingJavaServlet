function changeContent(contentId, contextPath){
    const element = document.getElementById("inner-content");

    if(contentId === "add"){
        element.innerHTML = `
            <form action="${contextPath}/dashboard/categories" method="post">
                <input name="action" value="add" hidden>
                <div>
                    <h2>Add Category</h2>
                </div>
                <div>
                    <label for="name">Name: </label>
                    <input type="text" name="name" id="name" required>
                </div>
                <div>
                    <button type="submit">Add</button>
                    <button type="button" class="btn-danger" onclick="location.href='${contextPath}/dashboard/categories'">Cancel</button>
                </div>
            </form>
        `;
    }
}

function edit(categoryId, categoryName, contextPath){
    document.getElementById("inner-content").innerHTML = `
        <form action="${contextPath}/dashboard/categories" method="post">
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
                <input type="text" name="name" id="name" value="${categoryName}" required>
            </div>
            <div>
                <button type="submit">Update</button>
                <button type="button" class="btn-danger" onclick="location.href='${contextPath}/dashboard/categories'">Cancel</button>
            </div>
        </form>
    `;
}

function deleteCategory(categoryId, categoryName, contextPath){
    document.getElementById("inner-content").innerHTML = `
        <form action="${contextPath}/dashboard/categories" method="post">
            <input name="action" value="delete" hidden>
            <div>
                <h2>Delete Category</h2>
                <p>Are you sure you want to delete this category?</p>
            </div>
            <div>
                <label for="id">Category Id: </label>
                <input type="text" name="id" id="id" value="${categoryId}" hidden>
            </div>
            <div>
                <label for="name">Name: </label>
                <input type="text" name="name" id="name" value="${categoryName}" disabled>
            </div>
            <span style="color:red;">This action cannot be reversed!</span>
            <div>
                <button type="submit" class="btn-danger">Delete</button>
                <button type="button" onclick="location.href='${contextPath}/dashboard/categories'">Cancel</button>
            </div>
        </form>
    `;
}