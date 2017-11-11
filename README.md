# Parallel Coordinates Visualization

## Sarah Pujol, Haihan Lin

### Initial Sketch

### Final Product
#### Full Visualization
![Alt text](https://github.com/angelicalin/COMP494-Parallel/blob/master/ParallelCoords/img/Screen%20Shot%202017-11-10%20at%202.17.40%20PM.png)

#### Data Filtering
![Alt text](https://github.com/angelicalin/COMP494-Parallel/blob/master/ParallelCoords/img/Screen%20Shot%202017-11-10%20at%202.20.08%20PM.png)

#### Number Label Hovering
![Alt text](https://github.com/angelicalin/COMP494-Parallel/blob/master/ParallelCoords/img/Screen%20Shot%202017-11-10%20at%202.21.40%20PM.png)

#### String Label Hovering
![Alt text](https://github.com/angelicalin/COMP494-Parallel/blob/master/ParallelCoords/img/Screen%20Shot%202017-11-10%20at%202.21.55%20PM.png)

### Design Decisions and Changes

We decided to use disconnected bars to visualize the different categories in order to not make people think of the x axis as a time line. The toggles are a bright blue color in order to differentiate them from the bars and have them stand out to the user. With the contrast in color the toggles pop out to the user and make it more obvious that they are meant to be interacted with. We made the toggles a very simple shape in order to not clutter up the visualization and keep the focus on the lines which are the most distinctive part of the visualization. We weren’t able to make the toggles boxes to show what values of a category are being displayed, this would have made it more obvious to the user where the toggle function is active.

The lines showing connections between categories are straight because we didn’t have time to implement a curvy line implementation. The curvy lines would have been better because it would have made better use of the space between the categories and distinguished the lines from each other. Right now a lot of lines are being drawn on top of each other which hides some of the data. In order to bring out the hidden data a bit we decided to make all of the lines opaque so there is a hint of the hidden data. We changed our design for coloring the lines because even though the gradient between two colors would have been beautiful it wouldn’t have shown our attributes correctly since they aren’t ordinal. Because our attributes are categorical we decided to try adding as many different colors as possible. The decision to use multiple colors instead of just one was made so that the user could begin to differentiate between singular lines. In order to put dissimilar colors next to each other we did a LABColor gradient between Red and Blue and then between Green and Purple. Then we colored every other data entry with the next color from the alternating gradients.

The decision to make the labels only appear on hover was because it is an extra level of detail about the information that not all users might find necessary, it also made the trends between categories harder to see and cluttered the view. Thus the labels for a bar only show up if the user hovers over it. Additionally if the labels for a bar are Strings we have only the one that is being hovered over shown so the labels don’t get too cluttered. Finally if there are more than 10 categories we decided to alternate the height of the category column labels in order to make them legible.

### Interactivity Implemenation

To change the data used, choose the data path in the first 3 lines of ParallelCoords.pde.

Upon running the program, the data will be processed and displayed with parallel coordinates.

The columns are initialized in the order as it appeared in the data set. And a polygonal line in unique color represents one entry in the data set. 

To rearrange the columns, click the two columns respectively. The first column will turn into blue if selected. And the columns are immediately rearranged after the second column is selected. If we had more time we would have liked to implement dragging the column to it’s destination. The lines would have moved smoothly from one position to the next. This would allow for a user to follow the trajectory of the lines as the data changed shape, creating a smoother visualization and allowing the user to use their eyes instead of memory in order to read the data. In order to create the dragging effect we would have updated the Bar columns x coordinate according to the mouseX variable. Then when each line is redrawn it would also use that x coordinate. We would do the switch once the mouseX value had overlapped another Bar’s X value.

To filter the data for a specific column, use the blue toggles on the ends of each column. Press and drag the toggle in the direction desired, and the data will be filtered immediately. Only the data within the range will be displayed. We think a minor improvement could be to add a clear box around the area that is being filtered down to. This would give the user a clear view of what information is being seen. It would also more clearly distinguish between the bars that are being filtered and the bars that are not being filtered. This would allow for a the user to understand the data more efficiently. Adding the box would be a simple solution of create a box that is a certain width and then having it’s length span between the max and min being shown.

To display the labels of a column, hover the mouse on the column, and all the label of the column will be displayed while the mouse is on the column. However, if the column has the datatype of String, only the label at the mouse position will be displayed instead. We added this interaction in order to keep the main data clean so the user can see the overall trends. If the user wants to see more detail for a trend such as the exact data being shown by a bar then then can hover over the specific bar they are interested in. For the String data type we only show one item at a time in order to keep the data clean and comprehensible. If we had had more time I would have liked to create a row/data Class in Processing to keep track of each single line of data and then highlight it and it’s labels at each Bar when the mouse hovers over it. The Class would keep track of the line’s position and label at each bar, and it’s specific color.
