<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vérification</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .verification-container {
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .verification-container:hover {
            transform: translateY(-5px);
        }
        
        .logo {
            margin-bottom: 20px;
        }
        
        .logo i {
            font-size: 50px;
            color: #6a11cb;
            margin-bottom: 10px;
        }
        
        h2 {
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        p {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .code-inputs {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .code-input {
            width: 60px;
            height: 60px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .code-input:focus {
            border-color: #6a11cb;
            outline: none;
            box-shadow: 0 0 0 3px rgba(106, 17, 203, 0.2);
        }
        
        .btn {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-top: 10px;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 15px rgba(106, 17, 203, 0.3);
        }
        
        .resend-link {
            margin-top: 20px;
            color: #6a11cb;
            cursor: pointer;
            font-weight: 500;
            display: inline-block;
            text-decoration: none;
            transition: all 0.3s;
            padding: 10px 15px;
            border-radius: 8px;
        }
        
        .resend-link:hover {
            background-color: rgba(106, 17, 203, 0.1);
            transform: translateY(-2px);
        }
        
        .message {
            margin-top: 20px;
            padding: 12px;
            border-radius: 8px;
            font-weight: 500;
        }
        
        .error {
            background-color: #ffeaea;
            color: #ff4757;
            border: 1px solid #ffcccc;
        }
        
        .success {
            background-color: #eaffea;
            color: #2ed573;
            border: 1px solid #ccffcc;
        }
        
        @media (max-width: 480px) {
            .verification-container {
                padding: 30px 20px;
            }
            
            .code-input {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="verification-container">
        <div class="logo">
            <i class="fas fa-shield-alt"></i>
        </div>
        
        <h2>Vérification de sécurité</h2>
        <p>Entrez le code à 4 chiffres envoyé à votre adresse email. Le code sera expiré après 5 minutes</p>
        
        <form id="verificationForm" action="VerificationServlet" method="post">
            <div class="code-inputs">
                <input type="text" class="code-input" maxlength="1" required>
                <input type="text" class="code-input" maxlength="1" required>
                <input type="text" class="code-input" maxlength="1" required>
                <input type="text" class="code-input" maxlength="1" required>
            </div>
            
            <input type="hidden" id="verificationCode" name="verificationCode">
            
            <button type="submit" class="btn" id="submitBtn">Vérifier</button>
        </form>
        
        <a href="/ProjetJEE/UserServlet" class="resend-link" id="resendLink">
            <i class="fas fa-redo-alt"></i> Renvoyer le code
        </a>
        
        <div class="message error" id="message" style="display: none;">
            ${message}
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const codeInputs = document.querySelectorAll('.code-input');
            const hiddenInput = document.getElementById('verificationCode');
            const messageElement = document.getElementById('message');
            
            // Focus sur le premier champ de code
            codeInputs[0].focus();
            
            // Gestion de la saisie du code
            codeInputs.forEach((input, index) => {
                input.addEventListener('input', function() {
                    // Ne permettre que les chiffres
                    this.value = this.value.replace(/\D/g, '');
                    
                    if (this.value.length === 1) {
                        if (index < codeInputs.length - 1) {
                            codeInputs[index + 1].focus();
                        } else {
                            codeInputs[index].blur();
                        }
                    }
                    updateHiddenInput();
                });
                
                input.addEventListener('keydown', function(e) {
                    if (e.key === 'Backspace' && this.value.length === 0 && index > 0) {
                        codeInputs[index - 1].focus();
                    }
                });
                
                input.addEventListener('paste', function(e) {
                    e.preventDefault();
                    const pasteData = e.clipboardData.getData('text').replace(/\D/g, '');
                    
                    // Remplir les champs avec les données collées
                    for (let i = 0; i < Math.min(pasteData.length, codeInputs.length); i++) {
                        codeInputs[i].value = pasteData[i];
                    }
                    
                    // Focus sur le dernier champ rempli
                    if (pasteData.length < codeInputs.length) {
                        codeInputs[pasteData.length].focus();
                    } else {
                        codeInputs[codeInputs.length - 1].focus();
                    }
                    
                    updateHiddenInput();
                });
            });
            
            // Mise à jour du champ caché avec le code complet
            function updateHiddenInput() {
                let code = '';
                codeInputs.forEach(input => {
                    code += input.value;
                });
                hiddenInput.value = code;
            }
            
            // Suppression de l'event listener qui empêchait la navigation
            // Le lien fonctionne maintenant normalement via GET vers /UserServlet
            
            // Gestion de l'affichage des messages d'erreur du serveur
            const serverMessage = "${message}";
            if (serverMessage && serverMessage.trim() !== "") {
                messageElement.textContent = serverMessage;
                // Déterminer si c'est un message d'erreur ou de succès basé sur le contenu
                if (serverMessage.includes("renvoyé") || serverMessage.includes("succès")) {
                    messageElement.className = "message success";
                } else {
                    messageElement.className = "message error";
                }
                messageElement.style.display = 'block';
            }
            
            // Empêcher l'envoi du formulaire si le code n'est pas complet
            document.getElementById('verificationForm').addEventListener('submit', function(e) {
                updateHiddenInput();
                if (hiddenInput.value.length !== 4) {
                    e.preventDefault();
                    messageElement.textContent = "Veuillez saisir un code complet à 4 chiffres.";
                    messageElement.className = "message error";
                    messageElement.style.display = 'block';
                    codeInputs[0].focus();
                }
            });
        });
    </script>
</body>
</html>
