# Sudoku API Integration Guide

## Direct Reference

### Basic Usage
```html
<img src="https://www.sudoku100.com/api" alt="Sudoku Puzzle">
```

### Specified Difficulty
```html
<img src="https://www.sudoku100.com/api/hard" alt="Hard Sudoku">
```

### Custom Size and Format
```html
<img src="https://www.sudoku100.com/api/hard/id/238/500.png" alt="Custom Sudoku">
```

## Website Integration

### With Solver Link
```html
<div class="sudoku-container">
  <h3>Daily Sudoku Challenge</h3>
  <img src="https://www.sudoku100.com/api/medium/id/100/600.png" alt="Daily Sudoku">
  <a href="https://www.sudoku100.com/api-solver" target="_blank">
    Click here to solve
  </a>
</div>
```

### Multiple Difficulty Selection
```html
<div class="sudoku-selector">
  <h3>Select Difficulty</h3>
  <div class="difficulty-buttons">
    <button data-difficulty="easy">Easy</button>
    <button data-difficulty="medium">Medium</button>
    <button data-difficulty="hard">Hard</button>
  </div>
  <img id="sudoku-image" src="https://www.sudoku100.com/api" alt="Sudoku Puzzle">
</div>

<script>
  document.querySelectorAll('.difficulty-buttons button').forEach(button => {
    button.addEventListener('click', function() {
      const difficulty = this.getAttribute('data-difficulty');
      document.getElementById('sudoku-image').src = `https://www.sudoku100.com/api/${difficulty}/id/100/600.png`;
    });
  });
</script>
```

## iframe Embedding

### Basic Embedding
```html
<iframe
  src="https://www.sudoku100.com/embed/interactive"
  width="800"
  height="600"
  style="border: none; overflow: hidden; border-radius: 6px;"
>
</iframe>
```

### Responsive Embedding
```html
<div style="position: relative; padding-bottom: 75%; height: 0;">
  <iframe
    src="https://www.sudoku100.com/embed/interactive"
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;"
  >
  </iframe>
</div>
```

## Large Language Model Integration

### Using Skill
```javascript
const SudokuApiSkill = require('./skill/sudoku-api-skill');

// Generate Sudoku puzzle
async function generateSudoku(difficulty = 'medium') {
  const result = await SudokuApiSkill.execute({ difficulty });
  return result.data.url;
}

// Example usage
generateSudoku('hard').then(url => {
  console.log('Sudoku URL:', url);
});
```

### Using MCP
```javascript
const SudokuApiMCP = require('./mcp/sudoku-api-mcp');

// Process user request
function handleSudokuRequest(prompt) {
  const request = { prompt };
  const response = SudokuApiMCP.process(request);
  
  // Generate API URL based on response
  let url = 'https://www.sudoku100.com/api';
  
  if (response.action === 'generate_sudoku' && response.parameters.difficulty && response.parameters.difficulty !== 'random') {
    url += `/${response.parameters.difficulty}`;
  } else if (response.action === 'get_sudoku_by_id' && response.parameters.id) {
    url += `/hard/id/${response.parameters.id}/500.png`;
  } else if (response.action === 'customize_sudoku') {
    const width = response.parameters.width || 500;
    const format = response.parameters.format || 'png';
    url += `/hard/id/238/${width}.${format}`;
  } else {
    url += '/generate';
  }
  
  return url;
}

// Example usage
const prompt = "Generate an expert difficulty Sudoku puzzle image";
const url = handleSudokuRequest(prompt);
console.log('Sudoku URL:', url);
```

## Mobile Application Integration

### iOS Example
```swift
import UIKit

class SudokuViewController: UIViewController {
    @IBOutlet weak var sudokuImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSudoku()
    }
    
    func loadSudoku() {
        let url = URL(string: "https://www.sudoku100.com/api/hard/id/238/600.png")!
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self?.sudokuImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
```

### Android Example
```java
import android.os.AsyncTask;
import android.widget.ImageView;
import com.squareup.picasso.Picasso;

public class SudokuActivity extends AppCompatActivity {
    private ImageView sudokuImageView;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sudoku);
        
        sudokuImageView = findViewById(R.id.sudoku_image);
        loadSudoku();
    }
    
    private void loadSudoku() {
        String url = "https://www.sudoku100.com/api/medium/id/100/600.png";
        Picasso.get().load(url).into(sudokuImageView);
    }
}
```

## Best Practices

1. **Caching Strategy** - For frequently used Sudoku, consider local caching
2. **Error Handling** - Implement proper error handling to deal with network issues
3. **Responsive Design** - Ensure proper display on different devices
4. **User Experience** - Add loading states and error messages
5. **Reasonable Usage** - Avoid excessive requests, respect API resources

## Troubleshooting

### Common Issues

1. **Image Not Displaying**
   - Check network connection
   - Verify URL format is correct
   - Ensure image size is between 100-1000px

2. **API Response Slow**
   - Consider using caching
   - Reduce request frequency
   - Optimize image size and format

3. **Format Not Supported**
   - Ensure using supported formats: png, webp, svg, jpg
   - Check format parameter is correct

4. **Invalid Difficulty Level**
   - Ensure using valid difficulty levels: beginner, easy, medium, hard, expert, extreme

## Integration Examples

### 1. Web Pages

```html
<!DOCTYPE html>
<html>
<head>
    <title>My Sudoku Page</title>
</head>
<body>
    <h1>Daily Sudoku</h1>
    <img src="https://www.sudoku100.com/api/medium/id/100/600.png"
         alt="Medium Difficulty Sudoku"
         loading="lazy">
</body>
</html>
```

### 2. Markdown Documents

```markdown
# Sudoku Puzzle

![Sudoku](https://www.sudoku100.com/api/easy/id/238/500.png)
```

### 3. Large Language Model Prompts

**Prompt:** "Generate a random Sudoku puzzle"
**Result:** Use `https://www.sudoku100.com/api`

**Prompt:** "Generate an expert difficulty Sudoku"
**Result:** Use `https://www.sudoku100.com/api/expert`

**Prompt:** "Show me puzzle number 500 in 800px width"
**Result:** Use `https://www.sudoku100.com/api/hard/id/500/800.png`

## URL Patterns

### Dynamic Generation
```
https://www.sudoku100.com/api
```
Generates a new Sudoku puzzle with each request.

### Static by ID
```
https://www.sudoku100.com/api/{difficulty}/id/{id}/{width}.{format}
```

### Examples:
- `https://www.sudoku100.com/api/easy/id/238/720.png`
- `https://www.sudoku100.com/api/hard/id/500/800.png`
- `https://www.sudoku100.com/api/medium/id/100/600.jpg`

## Difficulty Levels

| Level | Description | Hint Count |
|-------|-------------|------------|
| beginner | For beginners | 45-50 |
| easy | Easy puzzles | 38-44 |
| medium | Medium difficulty | 32-37 |
| hard | Challenging puzzles | 26-31 |
| expert | Expert level | 20-25 |
| extreme | Most challenging | 17-19 |

## Support

For integration issues, please contact us through:
- Email: support@sudoku100.com
- Website: https://www.sudoku100.com
- GitHub Issues: https://github.com/sudoku100com-create/Sudoku-generate-API/issues
