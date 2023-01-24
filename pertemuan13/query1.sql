CREATE TABLE OrderItems
(
OrderID INT NOT NULL,
Item VARCHAR(20) NOT NULL,
Quantity SMALLINT NOT NULL,
PRIMARY KEY(OrderID, Item)
);

INSERT INTO OrderItems (OrderID, Item, Quantity)
VALUES
(1, 'M8 Bolt', 100),
(2, 'M8 Nut', 100),
(3, 'M8 Washer', 200);

DECLARE OrderItemCursor CURSOR FAST_FORWARD
FOR
SELECT OrderID,
    SUM(Quantity) AS NumItems
FROM OrderItems
GROUP BY OrderID
ORDER BY OrderID;
DECLARE @OrderID INT, @NumItems INT;

-- Instantiate the cursor and loop through all orders.
OPEN OrderItemCursor;

FETCH NEXT FROM OrderItemCursor
INTO @OrderID, @NumItems
WHILE @@Fetch_Status = 0
    BEGIN;
    IF @NumItems > 100
        PRINT 'EXECUTING LogLargeOrder - '
        + CAST(@OrderID AS VARCHAR(5))
        + ' ' + CAST(@NumItems AS VARCHAR(5));
    ELSE
        PRINT 'EXECUTING LogSmallOrder - '
        + CAST(@OrderID AS VARCHAR(5))
        + ' ' + CAST(@NumItems AS VARCHAR(5));
FETCH NEXT FROM OrderItemCursor
INTO @OrderID, @NumItems;
END;

-- Close and deallocate the cursor.
CLOSE OrderItemCursor;
DEALLOCATE OrderItemCursor;