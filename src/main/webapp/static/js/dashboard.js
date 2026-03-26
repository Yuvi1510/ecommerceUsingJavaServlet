function changeContent(contentId) {
    const element = document.getElementById('inner-content');
    if(contentId === 'findUserById') {
        element.innerHTML = `
             <form id="findUserByIdForm" action="/dashboard" method="post">
         <input name="action" value="findById" hidden>
                <div>
                <label for="userId">User ID:</label>
                <input type="text" id="userId" name="userId" required>
                </div>
                 <div>
                            <button type="submit">Find User</button>
                             <a href="/dashboard"><button >Cancel</button></a>
                            </div>
            </form>
        `;
    }else if(contentId === "findUserByEmail"){
        element.innerHTML = `
         <form id="findUserByEmailForm" action="/dashboard" method="post">
         <input name="action" value="findByEmail" hidden>
                <div>
                <label for="userEmail">User Email:</label>
                <input type="email" id="userEmail" name="email" required>
                </div>
                 <div>
                            <button type="submit">Find User</button>
                             <a href="/dashboard"><button >Cancel</button></a>
                            </div>
            </form>
        
        `;
    }else if(contentId === "addUser"){
        element.innerHTML = `
<form action="/dashboard" method="POST">
<input type="text" hidden name="action" value="add">
                            <div>
                                <label for="first-name">First Name:</label>
                                <input
                                    type="text"
                                    id="first-name"
                                    name="firstName"
                                    required
                                >
                            </div>
                            <div>
                                <label for="last-name">Last Name:</label>
                                <input
                                    type="text"
                                    id="last-name"
                                    name="lastName"
                                    required
                                >
                            </div>
                            <div>
                                <label for="dob">Date of Birth:</label>
                                <input
                                    type="date"
                                    id="dob"
                                    name="dob"
                                    required
                                >
                            </div>
                            <div>
                                <label for="email">Email:</label>
                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    required
                                >
                            </div>
                            <div>
                                <label for="phone">Phone:</label>
                                <input
                                    type="tel"
                                    id="phone"
                                    name="phone"
                                    required
                                >
                            </div>
                            <div>
                                <label for="address">Address:</label>
                                <input id="address" name="address" required></input>
                            </div>
                            <div>
                                <label for="password">Password:</label>
                                <input id="password" name="password" required></input>
                            </div>
                             <div>
                            <button type="submit">Add User</button>
                             <a href="/dashboard"><button >Cancel</button></a>
                            </div>
                        </form>`
    }
}

function editUser(userId, firstName, lastName, dob, email, phone, address){
    console.log("updating user")
    const element = document.getElementById("inner-content");
    element.innerHTML = `
<form action="/dashboard" method="POST">
<input name="action" value="edit" hidden >
<div>
                                <label for="user-id">First Name:</label>
                                <input
                                    type="text"
                                    id="user-id"
                                    name="userId"
                                    value="${userId}"
                                    hidden
                                >
                            </div>
                            <div>
                                <label for="first-name">First Name:</label>
                                <input
                                    type="text"
                                    id="first-name"
                                    name="firstName"
                                    required
                                    value="${firstName}"
                                >
                            </div>
                            <div>
                                <label for="last-name">Last Name:</label>
                                <input
                                    type="text"
                                    id="last-name"
                                    name="lastName"
                                    required
                                    value="${lastName}"
                                >
                            </div>
                            <div>
                                <label for="dob">Date of Birth:</label>
                                <input
                                    type="date"
                                    id="dob"
                                    name="dob"
                                    required
                                    value="${dob}"
                                >
                            </div>
                            <div>
                                <label for="email">Email:</label>
                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    required
                                    value="${email}"
                                >
                            </div>
                            <div>
                                <label for="phone">Phone:</label>
                                <input
                                    type="tel"
                                    id="phone"
                                    name="phone"
                                    required
                                    value="${phone}"
                                >
                            </div>
                            <div>
                                <label for="address">Address:</label>
                                <input id="address" name="address" value="${address}" required></input>
                            </div>
                             <div>
                            <button type="submit">Update User</button>
                             <a href="/dashboard"><button >Cancel</button></a>
                            </div>
                        </form>`;
}


function deleteUser(userId, firstName, lastName, dob, email, phone, address){
    console.log("deleting user")
    const element = document.getElementById("inner-content");
    element.innerHTML = `
<form action="/dashboard" method="POST">
<input name="action" value="delete" hidden >
<div>
                                <label for="user-id">User ID:</label>
                                <input
                                    type="text"
                                    id="user-id"
                                    name="userId"
                                    value="${userId}"
                                    hidden
                                >
                            </div>
                            <div>
                                <label for="first-name">First Name:</label>
                                <input
                                    type="text"
                                    id="first-name"
                                    name="firstName"
                                    disabled
                                    value="${firstName}"
                                >
                            </div>
                            <div>
                                <label for="last-name">Last Name:</label>
                                <input
                                    type="text"
                                    id="last-name"
                                    name="lastName"
                                    disabled
                                    value="${lastName}"
                                >
                            </div>
                            <div>
                                <label for="dob">Date of Birth:</label>
                                <input
                                    type="date"
                                    id="dob"
                                    name="dob"
                                    disabled
                                    value="${dob}"
                                >
                            </div>
                            <div>
                                <label for="email">Email:</label>
                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    disabled
                                    value="${email}"
                                >
                            </div>
                            <div>
                                <label for="phone">Phone:</label>
                                <input
                                    type="tel"
                                    id="phone"
                                    name="phone"
                                    disabled
                                    value="${phone}"
                                >
                            </div>
                            <div>
                                <label for="address">Address:</label>
                                <input id="address" name="address" value="${address}" disabled></input>
                            </div>
                            <span style="color:red;">This action can not be reversed!</span>
                             <div>
                            <button type="submit">Delete User</button>
                             <a href="/dashboard"><button >Cancel</button></a>
                            </div>
                        </form>`;
}
