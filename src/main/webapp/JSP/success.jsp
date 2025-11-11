<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Succès de la vérification</title>
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
        
        .success-container {
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            padding: 50px 40px;
            width: 100%;
            max-width: 500px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .success-container:hover {
            transform: translateY(-5px);
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #2ed573 0%, #7bed9f 100%);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 30px;
            animation: pulse 2s infinite;
        }
        
        .success-icon i {
            font-size: 50px;
            color: white;
        }
        
        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(46, 213, 115, 0.7);
            }
            70% {
                box-shadow: 0 0 0 20px rgba(46, 213, 115, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(46, 213, 115, 0);
            }
        }
        
        h1 {
            color: #2ed573;
            margin-bottom: 20px;
            font-weight: 700;
            font-size: 32px;
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
            font-size: 18px;
        }
        
        .btn {
            display: inline-block;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            text-decoration: none;
            border: none;
            padding: 15px 40px;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
            box-shadow: 0 5px 15px rgba(106, 17, 203, 0.3);
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(106, 17, 203, 0.4);
        }
        
        .additional-info {
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #eee;
        }
        
        .additional-info h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }
        
        .additional-info p {
            font-size: 14px;
            color: #888;
            margin-bottom: 10px;
        }
        
        @media (max-width: 480px) {
            .success-container {
                padding: 40px 25px;
            }
            
            .success-icon {
                width: 80px;
                height: 80px;
            }
            
            .success-icon i {
                font-size: 40px;
            }
            
            h1 {
                font-size: 28px;
            }
            
            p {
                font-size: 16px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="success-container">
        <div class="success-icon">
            <i class="fas fa-check"></i>
        </div>
        
        <h1>Succès !</h1>
        <h2>Vérification terminée</h2>
        <p>${message}.</p>
        
        <a href="/ProjetJEE/login" class="btn">Se connecter</a>
        
       
    </div>
</body>
</html>