

function changeContent(contentId){
    let options = categories.map(cat => `
    <option value="${cat.id}" >
        ${cat.name}
    </option>
`).join("");

    console.log(categories);
    console.log(options);

    const element = document.getElementById("inner-content");

    if(contentId === "addProduct"){
        element.innerHTML = `
          <form action="/products" method="post">
          <input name="action" value="add" hidden>
                            <div>
                                <label for="name">Name: </label>
                                <input type="text" name="name">
                            </div>
                            <div>
                                <label for="description">Description: </label>
                                <input type="text" name="description">
                            </div>
                            <div>
                                <label for="image">Image: </label>
                                <input type="text" name="image">
                            </div>
                            <div>
                                <label for="price">Price: </label>
                                <input type="text" name="price">
                            </div>
                            <div>
                                <label for="quantity">Quantity: </label>
                                <input type="text" name="quantity">
                            </div>
                            <div>
                                <label for="category">Category: </label>
                                <select name="category" id="">
                                 ${options}
                                </select>
                            </div>
                            <div>
                            <button type="submit">Add Product</button>
                            <a href="/products"><button >Cancel</button></a>
</div>
                        </form>`;
    }else if(contentId === "findProductsByName"){
        element.innerHTML = ` <form action="/products" method="post">
 <input name="action" hidden value="findProductsByName">
                        <div>
                            <label for="name">Name: </label>
                            <input type="text" name="name">
                        </div>
                        <div>
                            <button type="submit">Find Product</button>
                            <a href="/products" class="btn-danger"><button >Cancel</button></a>
                        </div>
                    </form>`;
    }else if(contentId === "findProductsByCategory"){
        element.innerHTML = ` <form action="/products" method="post">
         <input name="action" hidden value="findProductsByCategory">

                        <div>
                            <label for="category">Category: </label>
                            <select name="category" id="">
                                ${options}
                            </select>
                        </div>
                       <div>
                            <button  type="submit">Find Product</button>
                            <a href="/products"><button class="btn-danger" >Cancel</button></a>
                            
</div>
                    </form>`;

    }else if(contentId === "findProductsById"){
        element.innerHTML = ` <form action="/products" method="post">
  <input name="action" hidden value="findProductsById">

                        <div>
                            <label for="id">ID: </label>
                            <input type="text" name="productId">
                        </div>
                       <div>
                            <button  type="submit">Find Product</button>
                            <a href="/products"><button class="btn-danger">Cancel</button></a>
                            
</div>
                    </form>`;
    }
}


function editProduct(id, name, description, image, price, quantity,categoryId, categories){
    let options = categories.map(cat => `
    <option value="${cat.id}" ${cat.id == categoryId ? "selected" : ""}>
        ${cat.name}
    </option>
`).join("");
    document.getElementById('inner-content').innerHTML = `
          <form action="/products" method="post">
          <input type="text" name="action" value="edit" hidden>
          <input type="text" name="id" value="${id}" hidden>
                            <div>
                                <label for="name">Name: </label>
                                <input type="text" name="name" value="${name}">
                            </div>
                            <div>
                                <label for="description">Description: </label>
                                <input type="text" name="description" value="${description}">
                            </div>
                            <div>
                                <label for="image">Image: </label>
                                <input type="text" value="${image}" name="image">
                            </div>
                            <div>
                                <label for="price">Price: </label>
                                <input type="text" value="${price}" name="price">
                            </div>
                            <div>
                                <label for="quantity">Quantity: </label>
                                <input type="text" value="${quantity}" name="quantity">
                            </div>
                            <div>
                                <label for="category">Category: </label>
                                  <select name="category" id="">
                                 ${options}
                                </select>
                            </div>
                             <div>
                            <button  type="submit">Update Product</button>
                            <button class="btn-danger"><a href="/products">Cancel</a></button>
                            
</div>
                        </form>`;
}

function deleteProduct(id, name, description, image, price, quantity, categoryId, categories){
    let options = categories.map(cat => `
    <option value="${cat.id}" ${cat.id == categoryId ? "selected" : ""}>
        ${cat.name}
    </option>
`).join("");
    document.getElementById('inner-content').innerHTML = `
          <form action="/products" method="post">
          <input type="text" name="action" value="delete" hidden>
          <input type="text" name="id" value="${id}" hidden>
                            <div>
                                <label for="name">Name: </label>
                                <input disabled type="text" name="name" value="${name}">
                            </div>
                            <div>
                                <label for="description">Description: </label>
                                <input disabled type="text" name="description" value="${description}">
                            </div>
                            <div>
                                <label for="image">Image: </label>
                                <input disabled type="text" value="${image}" name="image">
                            </div>
                            <div>
                                <label for="price">Price: </label>
                                <input disabled type="text" value="${price}" name="price">
                            </div>
                            <div>
                                <label for="quantity">Quantity: </label>
                                <input disabled type="text" value="${quantity}" name="quantity">
                            </div>
                            <div>
                                 <label for="category">Category: </label>
                                  <select name="category" disabled  id="">
                                ${options}
                                </select>
                            </div>
                            <div>
                            <button class="btn-danger" type="submit">Delete Product</button>
                            <a href="/products"><button >Cancel</button></a>
                            
</div>
                        </form>`;
}