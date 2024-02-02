defmodule App.QuizTest do
  use App.DataCase

  alias App.Quiz

  describe "stories" do
    alias App.Quiz.Story

    import App.QuizFixtures

    @invalid_attrs %{context: nil}

    test "list_stories/0 returns all stories" do
      story = story_fixture()
      assert Quiz.list_stories() == [story]
    end

    test "get_story!/1 returns the story with given id" do
      story = story_fixture()
      assert Quiz.get_story!(story.id) == story
    end

    test "create_story/1 with valid data creates a story" do
      valid_attrs = %{context: "some context"}

      assert {:ok, %Story{} = story} = Quiz.create_story(valid_attrs)
      assert story.context == "some context"
    end

    test "create_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_story(@invalid_attrs)
    end

    test "update_story/2 with valid data updates the story" do
      story = story_fixture()
      update_attrs = %{context: "some updated context"}

      assert {:ok, %Story{} = story} = Quiz.update_story(story, update_attrs)
      assert story.context == "some updated context"
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = story_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_story(story, @invalid_attrs)
      assert story == Quiz.get_story!(story.id)
    end

    test "delete_story/1 deletes the story" do
      story = story_fixture()
      assert {:ok, %Story{}} = Quiz.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = story_fixture()
      assert %Ecto.Changeset{} = Quiz.change_story(story)
    end
  end

  describe "questions" do
    alias App.Quiz.Question

    import App.QuizFixtures

    @invalid_attrs %{content: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Quiz.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Quiz.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %Question{} = question} = Quiz.create_question(valid_attrs)
      assert question.content == "some content"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Question{} = question} = Quiz.update_question(question, update_attrs)
      assert question.content == "some updated content"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_question(question, @invalid_attrs)
      assert question == Quiz.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Quiz.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Quiz.change_question(question)
    end
  end

  describe "answers" do
    alias App.Quiz.Answer

    import App.QuizFixtures

    @invalid_attrs %{content: nil, is_correct: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Quiz.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Quiz.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{content: "some content", is_correct: true}

      assert {:ok, %Answer{} = answer} = Quiz.create_answer(valid_attrs)
      assert answer.content == "some content"
      assert answer.is_correct == true
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{content: "some updated content", is_correct: false}

      assert {:ok, %Answer{} = answer} = Quiz.update_answer(answer, update_attrs)
      assert answer.content == "some updated content"
      assert answer.is_correct == false
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_answer(answer, @invalid_attrs)
      assert answer == Quiz.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Quiz.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Quiz.change_answer(answer)
    end
  end

  describe "completed_stories" do
    alias App.Quiz.CompletedStory

    import App.QuizFixtures

    @invalid_attrs %{is_completed: nil}

    test "list_completed_stories/0 returns all completed_stories" do
      completed_story = completed_story_fixture()
      assert Quiz.list_completed_stories() == [completed_story]
    end

    test "get_completed_story!/1 returns the completed_story with given id" do
      completed_story = completed_story_fixture()
      assert Quiz.get_completed_story!(completed_story.id) == completed_story
    end

    test "create_completed_story/1 with valid data creates a completed_story" do
      valid_attrs = %{is_completed: true}

      assert {:ok, %CompletedStory{} = completed_story} = Quiz.create_completed_story(valid_attrs)
      assert completed_story.is_completed == true
    end

    test "create_completed_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_completed_story(@invalid_attrs)
    end

    test "update_completed_story/2 with valid data updates the completed_story" do
      completed_story = completed_story_fixture()
      update_attrs = %{is_completed: false}

      assert {:ok, %CompletedStory{} = completed_story} = Quiz.update_completed_story(completed_story, update_attrs)
      assert completed_story.is_completed == false
    end

    test "update_completed_story/2 with invalid data returns error changeset" do
      completed_story = completed_story_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_completed_story(completed_story, @invalid_attrs)
      assert completed_story == Quiz.get_completed_story!(completed_story.id)
    end

    test "delete_completed_story/1 deletes the completed_story" do
      completed_story = completed_story_fixture()
      assert {:ok, %CompletedStory{}} = Quiz.delete_completed_story(completed_story)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_completed_story!(completed_story.id) end
    end

    test "change_completed_story/1 returns a completed_story changeset" do
      completed_story = completed_story_fixture()
      assert %Ecto.Changeset{} = Quiz.change_completed_story(completed_story)
    end
  end

  describe "mcqs" do
    alias App.Quiz.Mcq

    import App.QuizFixtures

    @invalid_attrs %{content: nil}

    test "list_mcqs/0 returns all mcqs" do
      mcq = mcq_fixture()
      assert Quiz.list_mcqs() == [mcq]
    end

    test "get_mcq!/1 returns the mcq with given id" do
      mcq = mcq_fixture()
      assert Quiz.get_mcq!(mcq.id) == mcq
    end

    test "create_mcq/1 with valid data creates a mcq" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %Mcq{} = mcq} = Quiz.create_mcq(valid_attrs)
      assert mcq.content == "some content"
    end

    test "create_mcq/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_mcq(@invalid_attrs)
    end

    test "update_mcq/2 with valid data updates the mcq" do
      mcq = mcq_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Mcq{} = mcq} = Quiz.update_mcq(mcq, update_attrs)
      assert mcq.content == "some updated content"
    end

    test "update_mcq/2 with invalid data returns error changeset" do
      mcq = mcq_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_mcq(mcq, @invalid_attrs)
      assert mcq == Quiz.get_mcq!(mcq.id)
    end

    test "delete_mcq/1 deletes the mcq" do
      mcq = mcq_fixture()
      assert {:ok, %Mcq{}} = Quiz.delete_mcq(mcq)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_mcq!(mcq.id) end
    end

    test "change_mcq/1 returns a mcq changeset" do
      mcq = mcq_fixture()
      assert %Ecto.Changeset{} = Quiz.change_mcq(mcq)
    end
  end

  describe "mcqs_answers" do
    alias App.Quiz.McqAnswer

    import App.QuizFixtures

    @invalid_attrs %{content: nil}

    test "list_mcqs_answers/0 returns all mcqs_answers" do
      mcq_answer = mcq_answer_fixture()
      assert Quiz.list_mcqs_answers() == [mcq_answer]
    end

    test "get_mcq_answer!/1 returns the mcq_answer with given id" do
      mcq_answer = mcq_answer_fixture()
      assert Quiz.get_mcq_answer!(mcq_answer.id) == mcq_answer
    end

    test "create_mcq_answer/1 with valid data creates a mcq_answer" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %McqAnswer{} = mcq_answer} = Quiz.create_mcq_answer(valid_attrs)
      assert mcq_answer.content == "some content"
    end

    test "create_mcq_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_mcq_answer(@invalid_attrs)
    end

    test "update_mcq_answer/2 with valid data updates the mcq_answer" do
      mcq_answer = mcq_answer_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %McqAnswer{} = mcq_answer} = Quiz.update_mcq_answer(mcq_answer, update_attrs)
      assert mcq_answer.content == "some updated content"
    end

    test "update_mcq_answer/2 with invalid data returns error changeset" do
      mcq_answer = mcq_answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_mcq_answer(mcq_answer, @invalid_attrs)
      assert mcq_answer == Quiz.get_mcq_answer!(mcq_answer.id)
    end

    test "delete_mcq_answer/1 deletes the mcq_answer" do
      mcq_answer = mcq_answer_fixture()
      assert {:ok, %McqAnswer{}} = Quiz.delete_mcq_answer(mcq_answer)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_mcq_answer!(mcq_answer.id) end
    end

    test "change_mcq_answer/1 returns a mcq_answer changeset" do
      mcq_answer = mcq_answer_fixture()
      assert %Ecto.Changeset{} = Quiz.change_mcq_answer(mcq_answer)
    end
  end

  describe "words" do
    alias App.Quiz.Word

    import App.QuizFixtures

    @invalid_attrs %{content: nil, hint: nil, sentence: nil}

    test "list_words/0 returns all words" do
      word = word_fixture()
      assert Quiz.list_words() == [word]
    end

    test "get_word!/1 returns the word with given id" do
      word = word_fixture()
      assert Quiz.get_word!(word.id) == word
    end

    test "create_word/1 with valid data creates a word" do
      valid_attrs = %{content: "some content", hint: "some hint", sentence: "some sentence"}

      assert {:ok, %Word{} = word} = Quiz.create_word(valid_attrs)
      assert word.content == "some content"
      assert word.hint == "some hint"
      assert word.sentence == "some sentence"
    end

    test "create_word/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_word(@invalid_attrs)
    end

    test "update_word/2 with valid data updates the word" do
      word = word_fixture()
      update_attrs = %{content: "some updated content", hint: "some updated hint", sentence: "some updated sentence"}

      assert {:ok, %Word{} = word} = Quiz.update_word(word, update_attrs)
      assert word.content == "some updated content"
      assert word.hint == "some updated hint"
      assert word.sentence == "some updated sentence"
    end

    test "update_word/2 with invalid data returns error changeset" do
      word = word_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_word(word, @invalid_attrs)
      assert word == Quiz.get_word!(word.id)
    end

    test "delete_word/1 deletes the word" do
      word = word_fixture()
      assert {:ok, %Word{}} = Quiz.delete_word(word)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_word!(word.id) end
    end

    test "change_word/1 returns a word changeset" do
      word = word_fixture()
      assert %Ecto.Changeset{} = Quiz.change_word(word)
    end
  end

  describe "levels" do
    alias App.Quiz.Level

    import App.QuizFixtures

    @invalid_attrs %{}

    test "list_levels/0 returns all levels" do
      level = level_fixture()
      assert Quiz.list_levels() == [level]
    end

    test "get_level!/1 returns the level with given id" do
      level = level_fixture()
      assert Quiz.get_level!(level.id) == level
    end

    test "create_level/1 with valid data creates a level" do
      valid_attrs = %{}

      assert {:ok, %Level{} = level} = Quiz.create_level(valid_attrs)
    end

    test "create_level/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_level(@invalid_attrs)
    end

    test "update_level/2 with valid data updates the level" do
      level = level_fixture()
      update_attrs = %{}

      assert {:ok, %Level{} = level} = Quiz.update_level(level, update_attrs)
    end

    test "update_level/2 with invalid data returns error changeset" do
      level = level_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_level(level, @invalid_attrs)
      assert level == Quiz.get_level!(level.id)
    end

    test "delete_level/1 deletes the level" do
      level = level_fixture()
      assert {:ok, %Level{}} = Quiz.delete_level(level)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_level!(level.id) end
    end

    test "change_level/1 returns a level changeset" do
      level = level_fixture()
      assert %Ecto.Changeset{} = Quiz.change_level(level)
    end
  end
end
