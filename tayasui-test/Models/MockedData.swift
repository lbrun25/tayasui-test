//
//  MockedData.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import Foundation
import UIKit

extension Recipe {
    static let mockedData: [Recipe] = [
        Recipe(
            name: "Tarte aux fraises",
            image: UIImage(named: "strawberries"),
            ingredients: "Sucre vanillé, Sucre glace, Sucre en poudre, Fraises, Sucre cristallisé, Biscuits à la cuillère, Pâte brisée, Rhubarbe, Oeufs, Crème liquide",
            duration: TimeInterval(60 * 170),
            directions: """
            1. Mélanger la rhubarbe avec les 100g de sucre et laisser macérer pendant 2h
            2. Préchauffer le four à 180°C.
            3. Déposer la pâte dans un moule à tarte, piquer à la fourchette.
            4. Emietter les biscuits sur le fond de tarte, verser la rhubarbe découpée en petits morceaux et le jus qui s'est constitué avec le sucre.
            5. Enfourner 20 min.
            6. Battre 2 jaunes, 1 oeuf, la crème, le sucre vanillé et 100 g de sucre.
            7. Verser le mélange sur la rhubarbe, enfourner 10 à 15 min.
            8. Monter les 2 blancs en neige en versant 100 g de sucre petit à petit.
            9. Retirer la tarte du four et garnir de meringue à l'aide d'une poche à douille (ou une cuillère).
            10. Saupoudrer de sucre glace (en utilisant une petite passoire pour tamiser).
            11. Remettre au four pour dorer (faire attention, ça dore très vite).
            12. Décorer de fraises coupées en 2.
            13. Servir frais.
            """,
            score: 2
        ),
        Recipe(
            name: "Flan au coco",
            image: UIImage(named: "coco"),
            ingredients: "Cannelle, Muscade, Lait de coco, Lait concentré sucré, Lait concentré non sucré, Oeufs, Caramel",
            duration: TimeInterval(60 * 55),
            directions: """
            1. Préchauffer le four à 180°C
            2. Mélanger les laits concentrés et le lait de coco. Ajouter les oeufs et les épices. Bien mélanger.
            3. Verser le caramel au fond d'un moule puis verser la préparation lactée.
            4. Enfourner 45 minutes.
            """,
            score: 3
        ),
        Recipe(
            name: "Gaspacho",
            image: UIImage(named: "gaspacho"),
            ingredients: "Framboises, Betteraves, Tomates, Tabasco, Huile d'olive, Vinaigre balsamique, Sucre, Sel et poivre",
            duration: TimeInterval(60 * 25),
            directions: """
            1. Dans un blender, mixer les framboises avec les betteraves et les tomates.
            2. Ajouter l'huile d'olive, le vinaigre balsamique, le tabasco, le sucre, le sel et le poivre. Mixer à nouveau jusqu'à obtenir une préparation lisse et homogène. Si besoin, ajouter un filet d'eau.
            3. Servir bien frais accompagné de tranches de pain grillées et frottées à l'ail.
            """,
            score: 2
        ),
    ]
    
    static let allImages: [UIImage?] = [
        UIImage(named: "coco"),
        UIImage(named: "gaspacho"),
        UIImage(named: "strawberries"),
    ]
}
