Use customer_behavior_df;
-- CALCULATE AVERAGE DURATION PER STAGE--
SELECT 
    Stage, 
    AVG(Duration) AS AverageDuration
FROM customer_journey
WHERE Duration IS NOT NULL
GROUP BY Stage
ORDER BY AverageDuration DESC;

-- Identify the drop off point---
SELECT 
    JourneyID, 
    CustomerID, 
    Stage, 
    VisitDate
FROM customer_journey
WHERE Action = 'Drop-off'
ORDER BY JourneyID, VisitDate;


-- Best rated product--
 
SELECT ProductID, AVG(Rating) AS AverageRating
FROM customer_reviews
GROUP BY ProductID
ORDER by AverageRating desc limit 5;

SELECT ProductID, AVG(Rating) AS AverageRating
FROM customer_reviews
GROUP BY ProductID
ORDER by AverageRating asc limit 5;

SELECT 
    p.ProductID, 
    p.ProductName, 
    COUNT(r.ReviewID) AS TotalReviews, 
    AVG(r.Rating) AS AvgRating, 
    MIN(r.Rating) AS MinRating, 
    MAX(r.Rating) AS MaxRating, 
    p.Price
FROM products p
LEFT JOIN customer_reviews r ON p.ProductID = r.ProductID
GROUP BY p.ProductID, p.ProductName, p.Price
ORDER BY AvgRating DESC;

-- Common action leading to succesful conversion
SELECT e.ContentType, 
sum(e.Likes) as TotalLikes,
sum(e.ViewsClicksCombined) as Total_views_click,
COUNT(c.Action) AS PurchaseCount
From engagement_data as e
JOIN customer_journey as c 
    ON e.ProductID = c.ProductID
WHERE c.Stage = 'Checkout' AND c.Action = 'Purchase'
group by ContentType
order by TotalLikes desc;