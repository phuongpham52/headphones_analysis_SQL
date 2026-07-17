# <p align="center">Amazon headphones sales analysis</p>
Global Headphones Market Analysis (SQL)

This project performs an exploratory data analysis (EDA) of the Global Headphones Market dataset. By utilizing SQL queries, I have uncovered insights regarding brand performance, pricing trends, and customer reception within the headphone industry.

Tools used: Excel, SQL (SQLite, SQLTools)

Dataset Used: (https://www.kaggle.com/datasets/maulikgajera/global-headphones-specifications-and-market-dataset)

Results: [Download the Data File](./headphones_results.xlsx)

Business Problem
The headphone market is saturated with countless brands and models, making it difficult for consumers to identify which products offer the best value or performance. The challenge lies in navigating a vast dataset of specifications and reviews to extract meaningful patterns. My goal is to provide a data-driven guide that helps consumers make informed purchasing decisions based on price, rating, and user feedback.

How I Solved the Problem
By leveraging SQL window functions and aggregation, I processed the dataset to uncover key performance indicators such as price-to-rating ratios, brand-specific excellence, and "hidden gem" products. I categorized products by price range to understand the market segments better and used statistical comparisons to see how individual models perform against their brand's average

SQL Analysis
## 1. Identifying Top-Tier Headphones
Goal: Find the best-performing models based on ratings and review volume.

Top 10 Highest Rated Headphones
```mysql
SELECT Brand, 
Model, 
"Battery (hrs)",
"Avg Rating"
FROM headphones
ORDER BY "Avg Rating" DESC
LIMIT 10;
```
Result:The Plantronics Go X has the highest rating with a rating of 5/5, and the following models also hold a perfect 5/5 rating: EarFun Drift 100, Sennheiser SRH 900X, SteelSeries True X, Grado Mini 300, Sony RE110, and Status Audio IE615.

While this SQL project does not explicitly define ratings based on battery life, nor is that the objective of the analysis, battery life remains a critical "look-out" factor for consumers when purchasing headphones. Customers prioritize battery capacity for several practical reasons: it minimizes the frequency of charging interruptions during long work sessions, ensures reliability during travel or commutes, and provides peace of mind that their device will remain functional throughout an entire day of heavy use without needing to be tethered to a power source.

Top 10 highest reviewed headphones
```mysql
SELECT Brand,
Model,
Connectivity,
"Avg Rating",
"Review Count"
FROM headphones
ORDER BY "Review Count" DESC
LIMIT 10;
```
Result:The EarFun Sound 100 holds the highest average rating in this dataset at 4.8/5, followed closely by the KZ T771 with a 4.7/5 rating.

Analysis of Ratings, Connectivity, and Review Volume
Connectivity Trends: Bluetooth connectivity is the dominant standard in this set, appearing in 8 out of the 10 models listed. The two 3.5mm models show a significant polarization in ratings: the KZ T771 is one of the highest-rated models (4.7/5), while the Rose RHA615 has the lowest rating (3.6/5).

Correlation Between Rating and Review Count: There is no clear positive correlation between the number of reviews and the average rating. In fact, some of the models with the highest review counts (e.g., Koss Ultra Pro with 9,986 reviews) hold relatively modest ratings (4.1/5), whereas the highest-rated model, the EarFun Sound 100 (4.8/5), has one of the lowest review counts (994). This suggests that a high volume of feedback does not necessarily guarantee a higher user satisfaction score in this specific dataset.

While this analysis focuses on performance metrics like ratings and review volume, connectivity remains a vital consideration for consumers. Whether a user chooses Bluetooth for the convenience of wireless mobility or opts for 3.5mm wired connections to ensure zero latency and consistent audio quality without battery dependence, the choice typically hinges on the user's specific use case, such as active exercise versus critical studio listening.

Insight: These queries distinguish between products that are critically acclaimed versus those that are mass-market favorites.

## 2. Market Performance by Brand
Goal: Understand how different brands position themselves in terms of quality and price.

Average rating by brand
```mysql
SELECT Brand,
round(AVG("Avg Rating"), 2) AS "Average Rating",
count(*) AS "Number of Models"
FROM headphones
GROUP BY Brand
ORDER BY "Average Rating" DESC;
```
Insight: This analysis helps identify which brands consistently deliver high-quality audio experiences compared to their average price point.

Result:Based on the data from the "Average rating by brand" and "Top 10 highest rated headphones" sheets, here is an analysis of the brand performance and ratings.

The Plantronics Go X has the highest rating with a rating of 5/5, and the following models also hold a perfect 5/5 rating: EarFun Drift 100, Sennheiser SRH 900X, SteelSeries True X, Grado Mini 300, Sony RE110, and Status Audio IE615.

Analysis of Ratings and Brand Models
Regarding the relationship between the number of models offered by a brand and its average rating, the analysis shows a very weak positive correlation (approximately 0.17). This indicates that the quantity of models produced by a brand has little to no significant impact on its average consumer rating. Quality control and individual product performance appear to be more influential drivers of ratings than the sheer volume of a brand's catalog.

The brand with the highest average rating is Razer, which maintains an average rating of 4.44 across its 23 models.

While this SQL project does not explicitly define ratings based on battery life, nor is that the objective of the analysis, battery life remains a critical "look-out" factor for consumers when purchasing headphones. Customers prioritize battery capacity for several practical reasons: it minimizes the frequency of charging interruptions during long work sessions, ensures reliability during travel or commutes, and provides peace of mind that their device will remain functional throughout an entire day of heavy use without needing to be tethered to a power source.

## 3. Price Segment Analysis
Goal: How does price bracket influence the user-perceived quality?

Average price by brand
```mysql
SELECT Brand,
round(AVG("Price (USD)"), 2) AS "Average Price",
count(*) AS "Number of Models"
FROM headphones
GROUP BY Brand
ORDER BY "Average Price" DESC;
```
Result: When examining the Average price by brand data, there is no meaningful correlation (a correlation coefficient of approximately 0.02) between the average price of a brand’s products and the number of models they offer.

This indicates that, for the brands in this dataset, a company's decision to offer a large volume of different models is not driven by the price tier of those products.

Summary Statistics
Average Price across all brands: $226.90

Average Number of Models per brand: ~37

Price Range: Brands average between a minimum of ~$162 and a maximum of ~$314

Model Diversity Range: Brands offer between 15 and 83 different models

In short, whether a brand focuses on budget-friendly or higher-end pricing, their strategy for how many distinct models to bring to market appears to be independent of their average price point.

Insight: This reveals if there is a "sweet spot" for pricing, where quality peaks before diminishing returns set in.

Average rating by price range

Insight: This reveals if there is a "sweet spot" for pricing, where quality peaks before diminishing returns set in.
Average rating by price range

```mysql
SELECT 
    CASE 
        WHEN CAST("Price (USD)" AS REAL) < 50 THEN 'Under $50'
        WHEN CAST("Price (USD)" AS REAL) BETWEEN 50 AND 99.99 THEN '$50-$99'
        WHEN CAST("Price (USD)" AS REAL) BETWEEN 100 AND 199.99 THEN '$100-$199'
        ELSE '$200+'
    END AS price_range,
    ROUND(AVG("Avg Rating"), 2) AS average_rating,
    COUNT(*) AS number_of_products
FROM headphones
GROUP BY price_range
ORDER BY 
    CASE price_range
        WHEN 'Under $50' THEN 1
        WHEN '$50-$99' THEN 2
        WHEN '$100-$199' THEN 3
        ELSE 4
    END;
```
Result:Price bracket has a negligible influence on user-perceived quality. The average ratings across all price segments are remarkably consistent, indicating that users perceive quality similarly regardless of the price paid:

Under $50: 4.28 average rating

$50–$99: 4.21 average rating

$100–$199: 4.26 average rating

$200+: 4.25 average rating

The data shows that higher-priced products do not correlate with higher satisfaction levels, as the ratings are tightly clustered between 4.21 and 4.28 across every category.


## 4. Segmented Performance: Top 5 Headphones by Primary Use
Goal: Identify the leaders in specific categories (e.g., Gaming, Studio, Travel).
Insight: This query uses ROW_NUMBER() to isolate the "best of the best" for each usage category, helping users quickly find the top recommended gear for their specific lifestyle.

Top 5 best rated headphones by primary use
```mysql
SELECT "Primary Use",
  brand,
  Model,
  "Price (USD)",
  round("Avg Rating", 2) AS "Average Rating"
FROM (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY "Primary Use" ORDER BY "Avg Rating" DESC) AS rn
  FROM headphones
) 
WHERE rn <= 5
ORDER BY "Primary Use", "Average Rating" DESC; 
```
Result: Several models achieve high ratings across their respective categories, serving as elite performers that significantly exceed their brand's overall average:

SteelSeries: True X (5.0 rating vs. 4.37 brand avg)

Sony: RE110 (5.0 rating vs. 4.21 brand avg)

Plantronics: Go X (5.0 rating vs. 4.14 brand avg)

EarFun: Drift 100 (5.0 rating vs. 4.31 brand avg)

Grado: Mini 300 (5.0 rating vs. 4.54 brand avg)

Status Audio: IE615 (5.0 rating vs. 4.26 brand avg)

Performance Context
When evaluating brand reputation, standout models are those that perform above the brand’s aggregate baseline. For instance, the Sony brand maintains an average rating of approximately 4.21. Models within the "Top 5" list—such as the RE110 (5.0), HE 250 (4.9), and Sport 900 (4.9), serve as significant outliers that elevate the brand's standing.

Similarly, for SteelSeries, which holds a brand average of 4.37, the True X (5.0) and Sound 100 (4.9) outperform the baseline, demonstrating that these specific products are driving the brand's positive reception in the competitive headphone market.

## 5. Within-Brand Ranking & Deviations
Goal: Identify standout models and how they compare to the brand average.
Insight: These window functions highlight "star performers"—products that significantly outperform their brand’s average—and "underperformers" that might drag a brand’s reputation down.

Ranking headphones by average rating within each brand
```mysql
SELECT 
    Brand,
    Model,
    "Avg Rating",
    "Review Count",
    RANK() OVER (
        PARTITION BY Brand 
        ORDER BY "Avg Rating" DESC, "Review Count" DESC
    ) AS rank
FROM headphones
ORDER BY Brand, rank;
```
Result:Standout Performers
Several models achieve a perfect rating of 5/5, positioning them as the top-tier "star performers" in the dataset:

Plantronics: Go X

EarFun: Drift 100

Grado: Mini 300

Sennheiser: SRH 900X

Sony: RE110

Status Audio: IE615

SteelSeries: True X

Performance Context
When analyzing brands, standout models are those whose individual Avg Rating exceeds the calculated Brand_Avg_Rating. For example, looking at the 1MORE brand, which has an overall average rating of approximately 4.27, models like the N661, Drops 700, Pro 2, Ultra X, and IE569 serve as significant outliers with ratings of 4.8, effectively pulling the brand's reputation upward.

Conversely, models like the SRH 1000 Open or IE269 (rated 4.1) fall below the 1MORE brand average, acting as potential "underperformers" that, while still highly rated in isolation, do not reach the standards set by the brand’s top-performing products.

## 6. Market Discovery: Hidden Gems & Volume Leaders
Goal: Find high-quality products that are under-the-radar vs. the most popular brands.
Insight: The "Hidden Gems" query helps identify high-quality products that lack the marketing budget of major brands, while the "Most Reviewed" query establishes which brands have the highest consumer engagement.
Products with high ratings but low review counts
```mysql
SELECT *
FROM headphones
WHERE "Avg Rating" >= 4.8
AND "Review Count" < 400;
```
Result: There are none that match the request.

## 7. Market Volume: Top 5 Most Reviewed Brands
Goal: Identify which brands dominate the market in terms of consumer engagement and review volume.

Top 5 most reviewed brand
```mysql
SELECT Brand,
"Avg Rating",
       COUNT(*) AS "Number of Models",
       SUM("Review Count") AS "Total Reviews"
FROM headphones
GROUP BY Brand
ORDER BY "Total Reviews" DESC
LIMIT 5;
```
Result: The top five most-reviewed brands drive the bulk of consumer engagement, with Grado leading in total review volume. The following analysis highlights these leaders and their standout models.

Market Engagement & Volume:

Grado281,650

Sennheiser272,199

Philips264,685

JBL256,843

Skullcandy251,505

Star Performers

These models exceed their brand’s calculated average, marking them as top-tier choices within their respective catalogs:

Grado: Mini 300 (5.0), EW88 (4.9)

Sennheiser: SRH 900X (5.0), N568 (4.9)

Philips: N777 (4.9), SRH 150 Limited (4.9)

JBL: N860 (4.9), Signature 5 (4.9)

Skullcandy: Ultra 1000 (4.9), RHA918 (4.9)

Brand Average Rating Context

Comparing model performance against the brand average identifies which products pull the brand's reputation upward:

Sennheiser: 4.33

Skullcandy: 4.30

JBL: 4.26Philips: 4.26

Grado: 4.20

Models exceeding these averages are consistent high-performers, whereas those falling below them act as underperformers that do not reach the standards set by the brand's best products.

## 8. Variance Analysis: Performance vs. Brand Average
Goal: Determine which specific models are "Outliers"—either significantly better or worse than the average product within their own brand.
Difference from brand average rating
```mysql
SELECT 
    Model,
    Brand,
    "Avg Rating",
    ROUND("Avg Rating" - AVG("Avg Rating") OVER(PARTITION BY Brand), 2) AS rating_difference
FROM headphones
ORDER BY ABS(rating_difference) DESC;
```
Result: Outlier AnalysisThe analysis defines outliers as models with a rating_difference exceeding two standard deviations from the mean ($\approx 0.66$).

Significantly Better Than Brand Average: The following models stand out as high-performance exceptions compared to their peers within the same brand: Simgot RE786 (rating difference of +0.84), Grado Mini 300 (+0.80), Sensaphonics T42 (+0.80), Sony RE110 (+0.79), and Dan Clark Audio SRH 300 Open (+0.77). These models represent the top tier of performance relative to their manufacturers' standard offerings.

Significantly Worse Than Brand Average: Conversely, the following models fall notably below their brand's expected average: Skullcandy SR 800Pro (-1.00), AKG LCD 500Pro (-0.99), Meze HE 100 (-0.99), Letshuoer T972 (-0.97), and JBL HE682 (-0.96). Consumers may want to approach these specific models with caution, as they perform well below the benchmark set by their respective product lines.


## Conclusion

The exploratory data analysis of the Global Headphones Market reveals a mature, highly competitive industry where consumer satisfaction is largely decoupled from pricing and brand scale. Through the application of SQL window functions and aggregation, several key strategic insights have emerged:

The Price-Quality Paradox: Contrary to conventional market expectations, there is a negligible relationship between price and user-perceived quality. With average ratings clustering consistently between 4.21 and 4.28 across all price segments (from under $50 to $200+), consumers are not guaranteed higher satisfaction simply by opting for premium-priced hardware. This indicates that "value for money" can be found across the entire pricing spectrum.

Performance Beyond Brand Identity: A brand’s aggregate reputation (its overall average rating) does not accurately predict the performance of its individual models. The analysis of "star performers" and "outliers" demonstrates that even brands with mediocre averages harbor elite products that significantly exceed expectations. Conversely, brands with high reputations often produce underperforming models that lag behind their own internal standards.

Engagement vs. Satisfaction: High review volume is not a proxy for product excellence. Some of the most reviewed products hold only moderate ratings, suggesting that consumer engagement is frequently driven by market saturation, marketing reach, or brand legacy rather than pure technical superiority or user delight.

Strategic Takeaway: For the consumer, the most effective purchasing strategy is not to rely on brand prestige or price tiers, but to hunt for individual model performance. The true "hidden gems" are those specific units that significantly exceed their brand’s average baseline. For stakeholders, this data highlights that market position is best maintained by focusing on consistent quality control across the product catalog to minimize "underperforming" outliers that can drag down a brand’s total perceived value.

In summary, the headphone market rewards the informed, analytical shopper who looks past labels and price tags to evaluate product-specific performance metrics.